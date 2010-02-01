// LLVMType.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteContext.h"
#import "LLVMConcreteType.h"
#import "LLVMType.h"
#import "AuspicionLLVM.h"

@implementation LLVMType

+(LLVMType *)integerTypeInContext:(LLVMContext *)context {
#ifdef __LP64__
	return [self int64TypeInContext: context];
#else
	return [self int32TypeInContext: context];
#endif
}


+(LLVMType *)int1TypeInContext:(LLVMContext *)context {
	return [LLVMConcreteType typeWithTypeRef: LLVMInt1TypeInContext(context.contextRef)];
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


+(LLVMType *)pointerTypeToType:(LLVMType *)type addressSpace:(NSUInteger)addressSpace {
	return [LLVMConcreteType typeWithTypeRef: LLVMPointerType(type.typeRef, addressSpace)];
}

+(LLVMType *)pointerTypeToType:(LLVMType *)type {
	return [self pointerTypeToType: type addressSpace: 0];
}

+(LLVMType *)untypedPointerTypeInContext:(LLVMContext *)context {
	return [self pointerTypeToType: [self int8TypeInContext: context] addressSpace: 0];
}


+(LLVMType *)voidTypeInContext:(LLVMContext *)context {
	return [LLVMConcreteType typeWithTypeRef: LLVMVoidTypeInContext(context.contextRef)];
}


+(LLVMType *)functionTypeWithReturnType:(LLVMType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic {
	LLVMTypeRef argumentTypeRefs[argumentTypes.count];
	NSUInteger i = 0;
	for(LLVMType *type in argumentTypes) {
		argumentTypeRefs[i++] = type.typeRef;
	}
	return [LLVMConcreteType typeWithTypeRef: LLVMFunctionType(_returnType.typeRef, argumentTypeRefs, argumentTypes.count, variadic)];
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


+(LLVMType *)structTypeInContext:(LLVMContext *)context withTypes:(NSArray *)types {
	LLVMTypeRef typeRefs[types.count];
	NSUInteger i = 0;
	for(LLVMType *type in types) {
		typeRefs[i++] = type.typeRef;
	}
	NSParameterAssert(context != nil);
	NSParameterAssert(types.count > 0);
	return [LLVMConcreteType typeWithTypeRef: LLVMStructTypeInContext(context.contextRef, typeRefs, types.count, NO)];
}


-(LLVMTypeRef)typeRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


-(LLVMContext *)context {
	return [[[LLVMConcreteContext alloc] initWithContextRef: LLVMGetTypeContext(self.typeRef)] autorelease];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintType(self.typeRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
