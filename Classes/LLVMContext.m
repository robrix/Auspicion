// LLVMContext.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMContext.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteType.h"
#import "LLVMConcreteValue.h"

@implementation LLVMContext

+(LLVMContext *)sharedContext {
	static LLVMContext *sharedContext = nil;
	if(!sharedContext) {
		sharedContext = [[[LLVMConcreteContext alloc] initWithContextRef: LLVMGetGlobalContext()] autorelease];
	}
	return sharedContext;
}


+(LLVMContext *)context {
	return [[[LLVMConcreteContext alloc] initWithContextRef: LLVMContextCreate()] autorelease];
}


-(LLVMContextRef)contextRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


// types
-(LLVMType *)integerType {
	return [LLVMType integerTypeInContext: self];
}

-(LLVMType *)int1Type {
	return [LLVMType int1TypeInContext: self];
}

-(LLVMType *)int8Type {
	return [LLVMType int8TypeInContext: self];
}

-(LLVMType *)int16Type {
	return [LLVMType int16TypeInContext: self];
}

-(LLVMType *)int32Type {
	return [LLVMType int32TypeInContext: self];
}

-(LLVMType *)int64Type {
	return [LLVMType int64TypeInContext: self];
}


-(LLVMType *)untypedPointerType {
	return [LLVMType untypedPointerTypeInContext: self];
}


// constants
-(LLVMValue *)constantInteger:(NSInteger)integer {
	return [LLVMConcreteValue valueWithValueRef: LLVMConstInt(self.integerType.typeRef, integer, 1)];
}

-(LLVMValue *)constantUnsignedInteger:(NSUInteger)integer {
	return [LLVMConcreteValue valueWithValueRef: LLVMConstInt(self.integerType.typeRef, integer, 0)];
}

-(LLVMValue *)constantInt32:(int32_t)integer {
	return [LLVMConcreteValue valueWithValueRef: LLVMConstInt(self.int32Type.typeRef, integer, 1)];
}

-(LLVMValue *)constantUnsignedInt32:(uint32_t)integer {
	return [LLVMConcreteValue valueWithValueRef: LLVMConstInt(self.int32Type.typeRef, integer, 0)];
}

@end