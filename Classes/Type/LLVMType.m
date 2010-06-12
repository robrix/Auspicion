// LLVMType.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMContext+Protected.h"
#import "LLVMStructureType.h"
#import "LLVMType.h"
#import "LLVMType+Protected.h"
#import "AuspicionLLVM.h"

@implementation LLVMType

-(id)initWithTypeRef:(LLVMTypeRef)_typeRef {
	if(self = [super init]) {
		typeRef = _typeRef;
	}
	return self;
}

+(Class)classForTypeKind:(LLVMTypeKind)kind {
	Class result = Nil;
	switch(kind) {
		case LLVMStructTypeKind:
			result = [LLVMStructureType class];
			break;
		default:
			result = self;
			break;
	}
	return result;
}

+(id)typeWithTypeRef:(LLVMTypeRef)_typeRef {
	return [[self classForTypeKind: LLVMGetTypeKind(_typeRef)] createUniqueInstanceForReference: _typeRef initializer: @selector(initWithTypeRef:)];
}

+(id)typeOfValueRef:(LLVMValueRef)valueRef {
	return [self typeWithTypeRef: LLVMTypeOf(valueRef)];
}


@synthesize typeRef;


-(LLVMTypeKind)typeKind {
	return LLVMGetTypeKind(self.typeRef);
}


+(LLVMType *)integerTypeInContext:(LLVMContext *)context {
#ifdef __LP64__
	return [self int64TypeInContext: context];
#else
	return [self int32TypeInContext: context];
#endif
}


+(LLVMType *)int1TypeInContext:(LLVMContext *)context {
	return [LLVMType typeWithTypeRef: LLVMInt1TypeInContext(context.contextRef)];
}

+(LLVMType *)int8TypeInContext:(LLVMContext *)context {
	return [LLVMType typeWithTypeRef: LLVMInt8TypeInContext(context.contextRef)];
}

+(LLVMType *)int16TypeInContext:(LLVMContext *)context {
	return [LLVMType typeWithTypeRef: LLVMInt16TypeInContext(context.contextRef)];
}

+(LLVMType *)int32TypeInContext:(LLVMContext *)context {
	return [LLVMType typeWithTypeRef: LLVMInt32TypeInContext(context.contextRef)];
}

+(LLVMType *)int64TypeInContext:(LLVMContext *)context {
	return [LLVMType typeWithTypeRef: LLVMInt64TypeInContext(context.contextRef)];
}


+(LLVMType *)floatTypeInContext:(LLVMContext *)context {
	return [LLVMType typeWithTypeRef: LLVMFloatTypeInContext(context.contextRef)];
}

+(LLVMType *)doubleTypeInContext:(LLVMContext *)context {
	return [LLVMType typeWithTypeRef: LLVMDoubleTypeInContext(context.contextRef)];
}


+(LLVMType *)pointerTypeToType:(LLVMType *)type addressSpace:(NSUInteger)addressSpace {
	return [LLVMType typeWithTypeRef: LLVMPointerType(type.typeRef, addressSpace)];
}

+(LLVMType *)pointerTypeToType:(LLVMType *)type {
	return [self pointerTypeToType: type addressSpace: 0];
}

+(LLVMType *)untypedPointerTypeInContext:(LLVMContext *)context {
	return [self pointerTypeToType: [self int8TypeInContext: context] addressSpace: 0];
}


+(LLVMType *)voidTypeInContext:(LLVMContext *)context {
	return [LLVMType typeWithTypeRef: LLVMVoidTypeInContext(context.contextRef)];
}


+(LLVMType *)functionTypeWithReturnType:(LLVMType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic {
	LLVMTypeRef argumentTypeRefs[argumentTypes.count];
	NSUInteger i = 0;
	for(LLVMType *type in argumentTypes) {
		argumentTypeRefs[i++] = type.typeRef;
	}
	return [LLVMType typeWithTypeRef: LLVMFunctionType(_returnType.typeRef, argumentTypeRefs, argumentTypes.count, variadic)];
}

+(LLVMType *)functionType:(LLVMType *)returnType, ... {
	va_list list;
	NSMutableArray *argumentTypes = [NSMutableArray array];
	va_start(list, returnType);
	LLVMType *argumentType = nil;
	while(argumentType = va_arg(list, LLVMType *)) {
		[argumentTypes addObject: argumentType];
	}
	va_end(list);
	return [self functionTypeWithReturnType: returnType argumentTypes: argumentTypes variadic: NO];
}


+(LLVMType *)arrayTypeWithCount:(NSUInteger)count type:(LLVMType *)type {
	return [LLVMType typeWithTypeRef: LLVMArrayType(type.typeRef, count)];
}

+(LLVMStructureType *)structTypeWithTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(LLVMType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(types.count > 0);
	return [LLVMType typeWithTypeRef: LLVMStructType(typeRefs, types.count, NO)];
}

+(LLVMStructureType *)structTypeInContext:(LLVMContext *)context withTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(LLVMType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(context != nil);
	NSParameterAssert(types.count > 0);
	return [LLVMType typeWithTypeRef: LLVMStructTypeInContext(context.contextRef, typeRefs, types.count, NO)];
}

+(LLVMType *)unionTypeWithTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(LLVMType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(types.count > 0);
	return [LLVMType typeWithTypeRef: LLVMUnionType(typeRefs, types.count)];
}


-(LLVMContext *)context {
	return [LLVMContext contextWithContextRef: LLVMGetTypeContext(self.typeRef)];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintType(self.typeRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
