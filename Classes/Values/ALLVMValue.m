// ALLVMValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ALLVMBlock+Protected.h"
#import "ALLVMBuilder.h"
#import "ALLVMContext.h"
#import "ALLVMFunction.h"
#import "ALLVMModule.h"
#import "ALLVMStructureValue.h"
#import "ALLVMType+Protected.h"
#import "ALLVMValue+Protected.h"
#import "AuspicionLLVM.h"

@implementation ALLVMValue

+(Class)classForTypeKind:(LLVMTypeKind)kind {
	Class result = Nil;
	switch(kind) {
		case LLVMStructTypeKind:
			result = [ALLVMStructureValue class];
			break;
		default:
			result = self;
			break;
	}
	return result;
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	return [[[[self classForTypeKind: [[ALLVMType typeOfValueRef: _valueRef] typeKind]] alloc] initWithValueRef: _valueRef name: _name] autorelease];
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef {
	return [[[[self classForTypeKind: [[ALLVMType typeOfValueRef: _valueRef] typeKind]] alloc] initWithValueRef: _valueRef name: @""] autorelease];
}

-(id)initWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	if(self = [super init]) {
		valueRef = _valueRef;
		NSParameterAssert(valueRef != NULL);
	}
	return self;
}


@synthesize valueRef;


-(NSString *)name {
	return [NSString stringWithUTF8String: LLVMGetValueName(self.valueRef)];
}

-(void)setName:(NSString *)name {
	LLVMSetValueName(self.valueRef, [name UTF8String]);
}


-(ALLVMType *)type {
	return [ALLVMType typeWithTypeRef: LLVMTypeOf(self.valueRef)];
}


-(ALLVMBlock *)parentBlock {
	return [ALLVMBlock blockWithBlockRef: LLVMGetInstructionParent(self.valueRef)];
}

-(ALLVMModule *)module {
	return self.parentBlock.parentFunction.module;
}

-(ALLVMContext *)context {
	return self.module.context;
}


-(ALLVMBuilder *)builder {
	return self.module.builder;
}


-(ALLVMBooleanValue *)equals:(ALLVMValue *)other {
	return [self.builder equal: self, other];
}

-(ALLVMBooleanValue *)notEquals:(ALLVMValue *)other {
	return [self.builder notEqual: self, other];
}


-(ALLVMValue *)plus:(ALLVMValue *)other {
	return [self.builder add: self, other];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
