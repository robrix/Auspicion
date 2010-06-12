// ALLVMType.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ALLVMContext+Protected.h"
#import "ALLVMStructureType.h"
#import "ALLVMType.h"
#import "ALLVMType+Protected.h"
#import "AuspicionLLVM.h"

@implementation ALLVMType

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
			result = [ALLVMStructureType class];
			break;
		default:
			result = self;
			break;
	}
	return result;
}

+(id)typeWithTypeRef:(LLVMTypeRef)_typeRef {
	NSParameterAssert(_typeRef != NULL);
	return [[self classForTypeKind: LLVMGetTypeKind(_typeRef)] createUniqueInstanceForReference: _typeRef initializer: @selector(initWithTypeRef:)];
}

+(id)typeOfValueRef:(LLVMValueRef)valueRef {
	return [self typeWithTypeRef: LLVMTypeOf(valueRef)];
}


@synthesize typeRef;


-(LLVMTypeKind)typeKind {
	return LLVMGetTypeKind(self.typeRef);
}


+(ALLVMType *)integerTypeInContext:(ALLVMContext *)context {
#ifdef __LP64__
	return [self int64TypeInContext: context];
#else
	return [self int32TypeInContext: context];
#endif
}


+(ALLVMType *)int1TypeInContext:(ALLVMContext *)context {
	return [ALLVMType typeWithTypeRef: LLVMInt1TypeInContext(context.contextRef)];
}

+(ALLVMType *)int8TypeInContext:(ALLVMContext *)context {
	return [ALLVMType typeWithTypeRef: LLVMInt8TypeInContext(context.contextRef)];
}

+(ALLVMType *)int16TypeInContext:(ALLVMContext *)context {
	return [ALLVMType typeWithTypeRef: LLVMInt16TypeInContext(context.contextRef)];
}

+(ALLVMType *)int32TypeInContext:(ALLVMContext *)context {
	return [ALLVMType typeWithTypeRef: LLVMInt32TypeInContext(context.contextRef)];
}

+(ALLVMType *)int64TypeInContext:(ALLVMContext *)context {
	return [ALLVMType typeWithTypeRef: LLVMInt64TypeInContext(context.contextRef)];
}


+(ALLVMType *)floatTypeInContext:(ALLVMContext *)context {
	return [ALLVMType typeWithTypeRef: LLVMFloatTypeInContext(context.contextRef)];
}

+(ALLVMType *)doubleTypeInContext:(ALLVMContext *)context {
	return [ALLVMType typeWithTypeRef: LLVMDoubleTypeInContext(context.contextRef)];
}


+(ALLVMType *)pointerTypeToType:(ALLVMType *)type addressSpace:(NSUInteger)addressSpace {
	NSParameterAssert(type != nil);
	return [ALLVMType typeWithTypeRef: LLVMPointerType(type.typeRef, addressSpace)];
}

+(ALLVMType *)pointerTypeToType:(ALLVMType *)type {
	return [self pointerTypeToType: type addressSpace: 0];
}

+(ALLVMType *)untypedPointerTypeInContext:(ALLVMContext *)context {
	return [self pointerTypeToType: [self int8TypeInContext: context] addressSpace: 0];
}


+(ALLVMType *)voidTypeInContext:(ALLVMContext *)context {
	return [ALLVMType typeWithTypeRef: LLVMVoidTypeInContext(context.contextRef)];
}


+(ALLVMType *)functionTypeWithReturnType:(ALLVMType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic {
	LLVMTypeRef argumentTypeRefs[argumentTypes.count];
	NSUInteger i = 0;
	for(ALLVMType *type in argumentTypes) {
		argumentTypeRefs[i++] = type.typeRef;
	}
	return [ALLVMType typeWithTypeRef: LLVMFunctionType(_returnType.typeRef, argumentTypeRefs, argumentTypes.count, variadic)];
}

+(ALLVMType *)functionType:(ALLVMType *)returnType, ... {
	va_list list;
	NSMutableArray *argumentTypes = [NSMutableArray array];
	va_start(list, returnType);
	ALLVMType *argumentType = nil;
	while(argumentType = va_arg(list, ALLVMType *)) {
		[argumentTypes addObject: argumentType];
	}
	va_end(list);
	return [self functionTypeWithReturnType: returnType argumentTypes: argumentTypes variadic: NO];
}


+(ALLVMType *)arrayTypeWithCount:(NSUInteger)count type:(ALLVMType *)type {
	return [ALLVMType typeWithTypeRef: LLVMArrayType(type.typeRef, count)];
}

+(ALLVMStructureType *)structureTypeWithTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(ALLVMType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(types.count > 0);
	return [ALLVMType typeWithTypeRef: LLVMStructType(typeRefs, types.count, NO)];
}

+(ALLVMStructureType *)structureTypeInContext:(ALLVMContext *)context withTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(ALLVMType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(context != nil);
	NSParameterAssert(types.count > 0);
	return [ALLVMType typeWithTypeRef: LLVMStructTypeInContext(context.contextRef, typeRefs, types.count, NO)];
}

+(ALLVMType *)unionTypeWithTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(ALLVMType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(types.count > 0);
	return [ALLVMType typeWithTypeRef: LLVMUnionType(typeRefs, types.count)];
}


-(ALLVMContext *)context {
	return [ALLVMContext contextWithContextRef: LLVMGetTypeContext(self.typeRef)];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintType(self.typeRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
