// ALLVMContext.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ALLVMContext+Protected.h"
#import "ALLVMType+Protected.h"
#import "ALLVMValue+Protected.h"
#import "NSObject+UniqueFactory.h"

@implementation ALLVMContext

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

+(ALLVMContext *)contextWithContextRef:(LLVMContextRef)_contextRef {
	return [self createUniqueInstanceForReference: _contextRef initializer: @selector(initWithContextRef:)];
}

+(ALLVMContext *)context {
	return [self contextWithContextRef: LLVMContextCreate()];
}


@synthesize contextRef;


// types
-(ALLVMType *)integerType {
	return [ALLVMType integerTypeInContext: self];
}

-(ALLVMType *)int1Type {
	return [ALLVMType int1TypeInContext: self];
}

-(ALLVMType *)int8Type {
	return [ALLVMType int8TypeInContext: self];
}

-(ALLVMType *)int16Type {
	return [ALLVMType int16TypeInContext: self];
}

-(ALLVMType *)int32Type {
	return [ALLVMType int32TypeInContext: self];
}

-(ALLVMType *)int64Type {
	return [ALLVMType int64TypeInContext: self];
}


-(ALLVMType *)untypedPointerType {
	return [ALLVMType untypedPointerTypeInContext: self];
}


-(ALLVMType *)voidType {
	return [ALLVMType voidTypeInContext: self];
}

-(ALLVMStructureType *)structureTypeWithTypes:(ALLVMType *)type, ... {
	NSMutableArray *types = [NSMutableArray arrayWithObject: type];
	va_list list;
	va_start(list, type);
	while(type = va_arg(list, ALLVMType *)) {
		[types addObject: type];
	}
	va_end(list);
	return [ALLVMType structureTypeInContext: self withTypes: types];
}


// constants
-(ALLVMValue *)constantInteger:(NSInteger)integer {
	return [ALLVMValue valueWithValueRef: LLVMConstInt(self.integerType.typeRef, integer, 1)];
}

-(ALLVMValue *)constantUnsignedInteger:(NSUInteger)integer {
	return [ALLVMValue valueWithValueRef: LLVMConstInt(self.integerType.typeRef, integer, 0)];
}

-(ALLVMValue *)constantInt64:(int64_t)integer {
	return [ALLVMValue valueWithValueRef: LLVMConstInt(self.int64Type.typeRef, integer, 1)];
}

-(ALLVMValue *)constantUnsignedInt64:(uint64_t)integer {
	return [ALLVMValue valueWithValueRef: LLVMConstInt(self.int64Type.typeRef, integer, 0)];
}

-(ALLVMValue *)constantInt32:(int32_t)integer {
	return [ALLVMValue valueWithValueRef: LLVMConstInt(self.int32Type.typeRef, integer, 1)];
}

-(ALLVMValue *)constantUnsignedInt32:(uint32_t)integer {
	return [ALLVMValue valueWithValueRef: LLVMConstInt(self.int32Type.typeRef, integer, 0)];
}


-(ALLVMValue *)constantUntypedPointer:(void *)pointer {
	return [ALLVMValue valueWithValueRef: LLVMConstIntToPtr(LLVMConstInt(self.integerType.typeRef, (NSUInteger)pointer, 0), self.untypedPointerType.typeRef)];
}


-(ALLVMValue *)constantNullOfType:(ALLVMType *)type {
	return [ALLVMValue valueWithValueRef: LLVMConstNull(type.typeRef)];
}


-(ALLVMValue *)constantStructure:(ALLVMValue *)value, ... {
	NSParameterAssert(value != nil);
	NSMutableArray *values = [NSMutableArray arrayWithObject: value];
	va_list list;
	va_start(list, value);
	while(value = va_arg(list, ALLVMValue *)) {
		[values addObject: value];
	}
	va_end(list);
	NSParameterAssert(values.count > 1);
	LLVMValueRef valueRefs[values.count];
	NSUInteger i = 0;
	for(ALLVMValue *value in values) {
		valueRefs[i++] = value.valueRef;
	}
	return [ALLVMValue valueWithValueRef: LLVMConstStructInContext(self.contextRef, valueRefs, values.count, NO)];
}

@end
