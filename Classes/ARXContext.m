// ARXContext.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ARXContext+Protected.h"
#import "ARXType+Protected.h"
#import "ARXValue+Protected.h"
#import "NSObject+UniqueFactory.h"

@implementation ARXContext

-(id)initWithContextRef:(LLVMContextRef)_contextRef {
	if(self = [super init]) {
		contextRef = _contextRef;
	}
	return self;
}

-(void)dealloc {
	LLVMContextDispose(contextRef);
	[super dealloc];
}

+(ARXContext *)contextWithContextRef:(LLVMContextRef)_contextRef {
	return [self createUniqueInstanceForReference: _contextRef initializer: @selector(initWithContextRef:)];
}

+(ARXContext *)context {
	return [self contextWithContextRef: LLVMContextCreate()];
}


@synthesize contextRef;


// types
-(ARXType *)integerType {
	return [ARXType integerTypeInContext: self];
}

-(ARXType *)int1Type {
	return [ARXType int1TypeInContext: self];
}

-(ARXType *)int8Type {
	return [ARXType int8TypeInContext: self];
}

-(ARXType *)int16Type {
	return [ARXType int16TypeInContext: self];
}

-(ARXType *)int32Type {
	return [ARXType int32TypeInContext: self];
}

-(ARXType *)int64Type {
	return [ARXType int64TypeInContext: self];
}


-(ARXType *)untypedPointerType {
	return [ARXType untypedPointerTypeInContext: self];
}


-(ARXType *)voidType {
	return [ARXType voidTypeInContext: self];
}

-(ARXStructureType *)structureTypeWithTypes:(ARXType *)type, ... {
	NSMutableArray *types = [NSMutableArray arrayWithObject: type];
	va_list list;
	va_start(list, type);
	while(type = va_arg(list, ARXType *)) {
		[types addObject: type];
	}
	va_end(list);
	return [ARXType structureTypeInContext: self withTypes: types];
}


// constants
-(ARXValue *)constantInteger:(NSInteger)integer {
	return [ARXValue valueWithValueRef: LLVMConstInt(self.integerType.typeRef, integer, 1)];
}

-(ARXValue *)constantUnsignedInteger:(NSUInteger)integer {
	return [ARXValue valueWithValueRef: LLVMConstInt(self.integerType.typeRef, integer, 0)];
}

-(ARXValue *)constantInt64:(int64_t)integer {
	return [ARXValue valueWithValueRef: LLVMConstInt(self.int64Type.typeRef, integer, 1)];
}

-(ARXValue *)constantUnsignedInt64:(uint64_t)integer {
	return [ARXValue valueWithValueRef: LLVMConstInt(self.int64Type.typeRef, integer, 0)];
}

-(ARXValue *)constantInt32:(int32_t)integer {
	return [ARXValue valueWithValueRef: LLVMConstInt(self.int32Type.typeRef, integer, 1)];
}

-(ARXValue *)constantUnsignedInt32:(uint32_t)integer {
	return [ARXValue valueWithValueRef: LLVMConstInt(self.int32Type.typeRef, integer, 0)];
}


-(ARXValue *)constantUntypedPointer:(void *)pointer {
	return [ARXValue valueWithValueRef: LLVMConstIntToPtr(LLVMConstInt(self.integerType.typeRef, (NSUInteger)pointer, 0), self.untypedPointerType.typeRef)];
}

-(ARXValue *)constantPointer:(void *)pointer ofType:(ARXType *)type {
	return [ARXValue valueWithValueRef: LLVMConstIntToPtr(LLVMConstInt(self.integerType.typeRef, (NSUInteger)pointer, 0), type.typeRef)];
}


-(ARXValue *)constantNullOfType:(ARXType *)type {
	return [ARXValue valueWithValueRef: LLVMConstNull(type.typeRef)];
}


-(ARXValue *)constantStructure:(ARXValue *)value, ... {
	NSParameterAssert(value != nil);
	NSMutableArray *values = [NSMutableArray arrayWithObject: value];
	va_list list;
	va_start(list, value);
	while(value = va_arg(list, ARXValue *)) {
		[values addObject: value];
	}
	va_end(list);
	NSParameterAssert(values.count > 1);
	LLVMValueRef valueRefs[values.count];
	NSUInteger i = 0;
	for(ARXValue *value in values) {
		valueRefs[i++] = value.valueRef;
	}
	return [ARXValue valueWithValueRef: LLVMConstStructInContext(self.contextRef, valueRefs, values.count, NO)];
}

@end
