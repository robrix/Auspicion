// LLVMType.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteContext.h"
#import "LLVMConcreteType.h"
#import "LLVMType.h"

@implementation LLVMType

+(LLVMType *)integerTypeInContext:(LLVMContext *)context {
#ifdef __LP64__
	return [LLVMConcreteType typeWithTypeRef: LLVMInt64TypeInContext(context.contextRef)];
#else
	return [LLVMConcreteType typeWithTypeRef: LLVMInt32TypeInContext(context.contextRef)];
#endif
}


+(LLVMType *)int8TypeInContext:(LLVMContext *)context {
	return [LLVMConcreteType typeWithTypeRef: LLVMInt8TypeInContext(context.contextRef)];
}

+(LLVMType *)int16TypeInContext:(LLVMContext *)context {
	return [LLVMConcreteType typeWithTypeRef: LLVMInt16TypeInContext(context.contextRef)];
}

+(LLVMType *)int32TypeInContext:(LLVMContext *)context {
	return [LLVMConcreteType typeWithTypeRef: LLVMInt32TypeInContext(context.contextRef)];
}

+(LLVMType *)int64TypeInContext:(LLVMContext *)context {
	return [LLVMConcreteType typeWithTypeRef: LLVMInt64TypeInContext(context.contextRef)];
}


+(LLVMType *)pointerInContext:(LLVMContext *)context toType:(LLVMType *)type addressSpace:(NSUInteger)addressSpace {
	return [LLVMConcreteType typeWithTypeRef: LLVMPointerType(type.typeRef, addressSpace)];
}

+(LLVMType *)functionTypeWithReturnType:(LLVMType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic {
	LLVMTypeRef argumentTypeRefs[argumentTypes.count];
	NSUInteger i = 0;
	for(LLVMType *type in argumentTypes) {
		argumentTypeRefs[i++] = type.typeRef;
	}
	return [LLVMConcreteType typeWithTypeRef: LLVMFunctionType(_returnType.typeRef, argumentTypeRefs, argumentTypes.count, variadic)];
}


-(LLVMTypeRef)typeRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

@end