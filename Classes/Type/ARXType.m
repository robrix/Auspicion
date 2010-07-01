// ARXType.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ARXBooleanType.h"
#import "ARXContext+Protected.h"
#import "ARXFunctionType.h"
#import "ARXPointerType.h"
#import "ARXStructureType.h"
#import "ARXType.h"
#import "ARXType+Protected.h"
#import "ARXValue.h"
#import "AuspicionLLVM.h"

@implementation ARXType

-(id)initWithTypeRef:(LLVMTypeRef)_typeRef {
	if(self = [super init]) {
		typeRef = _typeRef;
	}
	return self;
}

+(Class)classForTypeRef:(LLVMTypeRef)typeRef {
	Class result = Nil;
	// if(LLVMGetTypeKind(typeRef) == LLVMPointerTypeKind) typeRef = LLVMGetElementType(typeRef);
	switch(LLVMGetTypeKind(typeRef)) {
		case LLVMStructTypeKind:
			result = [ARXStructureType class];
			break;
		case LLVMFunctionTypeKind:
			result = [ARXFunctionType class];
			break;
		case LLVMPointerTypeKind:
			{
				LLVMTypeKind referencedTypeKind = LLVMGetTypeKind(LLVMGetElementType(typeRef));
				if(referencedTypeKind == LLVMFunctionTypeKind) {
					result = [ARXFunctionType class];
				} else {
					result = [ARXPointerType class];
				}
			}
			break;
		case LLVMIntegerTypeKind:
			if(LLVMGetIntTypeWidth(typeRef) == 1) {
				result = [ARXBooleanType class];
				break;
			}
		default:
			result = self;
			break;
	}
	return result;
}

+(id)typeWithTypeRef:(LLVMTypeRef)_typeRef {
	NSParameterAssert(_typeRef != NULL);
	return [[self classForTypeRef: _typeRef] createUniqueInstanceForReference: _typeRef initializer: @selector(initWithTypeRef:)];
}

+(id)typeOfValueRef:(LLVMValueRef)valueRef {
	NSParameterAssert(valueRef != NULL);
	return [self typeWithTypeRef: LLVMTypeOf(valueRef)];
}


@synthesize typeRef;


-(LLVMTypeKind)typeKind {
	return LLVMGetTypeKind(self.typeRef);
}


+(ARXType *)integerTypeInContext:(ARXContext *)context {
#ifdef __LP64__
	return [self int64TypeInContext: context];
#else
	return [self int32TypeInContext: context];
#endif
}


+(ARXType *)int1TypeInContext:(ARXContext *)context {
	return [ARXType typeWithTypeRef: LLVMInt1TypeInContext(context.contextRef)];
}

+(ARXType *)int8TypeInContext:(ARXContext *)context {
	return [ARXType typeWithTypeRef: LLVMInt8TypeInContext(context.contextRef)];
}

+(ARXType *)int16TypeInContext:(ARXContext *)context {
	return [ARXType typeWithTypeRef: LLVMInt16TypeInContext(context.contextRef)];
}

+(ARXType *)int32TypeInContext:(ARXContext *)context {
	return [ARXType typeWithTypeRef: LLVMInt32TypeInContext(context.contextRef)];
}

+(ARXType *)int64TypeInContext:(ARXContext *)context {
	return [ARXType typeWithTypeRef: LLVMInt64TypeInContext(context.contextRef)];
}


+(ARXType *)floatTypeInContext:(ARXContext *)context {
	return [ARXType typeWithTypeRef: LLVMFloatTypeInContext(context.contextRef)];
}

+(ARXType *)doubleTypeInContext:(ARXContext *)context {
	return [ARXType typeWithTypeRef: LLVMDoubleTypeInContext(context.contextRef)];
}


+(ARXType *)pointerTypeToType:(ARXType *)type addressSpace:(NSUInteger)addressSpace {
	NSParameterAssert(type != nil);
	return [ARXType typeWithTypeRef: LLVMPointerType(type.typeRef, addressSpace)];
}

+(ARXType *)pointerTypeToType:(ARXType *)type {
	return [self pointerTypeToType: type addressSpace: 0];
}

+(ARXType *)untypedPointerTypeInContext:(ARXContext *)context {
	return [self pointerTypeToType: [self int8TypeInContext: context] addressSpace: 0];
}


+(ARXType *)voidTypeInContext:(ARXContext *)context {
	return [ARXType typeWithTypeRef: LLVMVoidTypeInContext(context.contextRef)];
}


+(ARXFunctionType *)functionTypeWithReturnType:(ARXType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic {
	LLVMTypeRef argumentTypeRefs[argumentTypes.count];
	NSUInteger i = 0;
	for(ARXType *type in argumentTypes) {
		argumentTypeRefs[i++] = type.typeRef;
	}
	return [ARXFunctionType typeWithTypeRef: LLVMFunctionType(_returnType.typeRef, argumentTypeRefs, argumentTypes.count, variadic)];
}

+(ARXFunctionType *)functionType:(ARXType *)returnType, ... {
	va_list list;
	NSMutableArray *argumentTypes = [NSMutableArray array];
	va_start(list, returnType);
	ARXType *argumentType = nil;
	while(argumentType = va_arg(list, ARXType *)) {
		[argumentTypes addObject: argumentType];
	}
	va_end(list);
	return [self functionTypeWithReturnType: returnType argumentTypes: argumentTypes variadic: NO];
}


+(ARXType *)arrayTypeWithCount:(NSUInteger)count type:(ARXType *)type {
	return [ARXType typeWithTypeRef: LLVMArrayType(type.typeRef, count)];
}

+(ARXStructureType *)structureTypeWithTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(ARXType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(types.count > 0);
	return [ARXType typeWithTypeRef: LLVMStructType(typeRefs, types.count, NO)];
}

+(ARXStructureType *)structureTypeWithTypes:(NSArray *)types inContext:(ARXContext *)context {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(ARXType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(types.count > 0);
	return [ARXType typeWithTypeRef: LLVMStructTypeInContext(context.contextRef, typeRefs, types.count, NO)];
}

+(ARXType *)unionTypeWithTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(ARXType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(types.count > 0);
	return [ARXType typeWithTypeRef: LLVMUnionType(typeRefs, types.count)];
}


-(ARXContext *)context {
	return [ARXContext contextWithContextRef: LLVMGetTypeContext(self.typeRef)];
}


-(Class)correspondingValueClass {
	return [ARXValue class];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintType(self.typeRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
