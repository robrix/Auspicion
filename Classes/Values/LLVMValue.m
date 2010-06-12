// LLVMValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMBlock+Protected.h"
#import "LLVMBuilder.h"
#import "LLVMContext.h"
#import "LLVMFunction.h"
#import "LLVMModule.h"
#import "LLVMStructureValue.h"
#import "LLVMType+Protected.h"
#import "LLVMValue+Protected.h"
#import "AuspicionLLVM.h"

@implementation LLVMValue

+(Class)classForTypeKind:(LLVMTypeKind)kind {
	Class result = Nil;
	switch(kind) {
		case LLVMStructTypeKind:
			result = [LLVMStructureValue class];
			break;
		default:
			result = self;
			break;
	}
	return result;
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	return [[[[self classForTypeKind: [[LLVMType typeOfValueRef: _valueRef] typeKind]] alloc] initWithValueRef: _valueRef name: _name] autorelease];
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef {
	return [[[[self classForTypeKind: [[LLVMType typeOfValueRef: _valueRef] typeKind]] alloc] initWithValueRef: _valueRef name: @""] autorelease];
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


-(LLVMType *)type {
	return [LLVMType typeWithTypeRef: LLVMTypeOf(self.valueRef)];
}


-(LLVMBlock *)parentBlock {
	return [LLVMBlock blockWithBlockRef: LLVMGetInstructionParent(self.valueRef)];
}

-(LLVMModule *)module {
	return self.parentBlock.parentFunction.module;
}

-(LLVMContext *)context {
	return self.module.context;
}


-(LLVMBuilder *)builder {
	return self.module.builder;
}


-(LLVMBooleanValue *)equals:(LLVMValue *)other {
	return [self.builder equal: self, other];
}

-(LLVMBooleanValue *)notEquals:(LLVMValue *)other {
	return [self.builder notEqual: self, other];
}


-(LLVMValue *)plus:(LLVMValue *)other {
	return [self.builder add: self, other];
}


-(LLVMValue *)value {
	return [self.builder get: self];
}

-(void)setValue:(LLVMValue *)value {
	[self.builder set: self, value];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
