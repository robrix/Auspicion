// ARXValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ARXBlock+Protected.h"
#import "ARXBuilder.h"
#import "ARXContext.h"
#import "ARXFunction.h"
#import "ARXModule.h"
#import "ARXStructureValue.h"
#import "ARXType+Protected.h"
#import "ARXValue+Protected.h"
#import "AuspicionLLVM.h"

@implementation ARXValue

+(Class)classForTypeKind:(LLVMTypeKind)kind {
	Class result = Nil;
	switch(kind) {
		case LLVMStructTypeKind:
			result = [ARXStructureValue class];
			break;
		default:
			result = self;
			break;
	}
	return result;
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	return [[[[self classForTypeKind: [[ARXType typeOfValueRef: _valueRef] typeKind]] alloc] initWithValueRef: _valueRef name: _name] autorelease];
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef {
	return [[[[self classForTypeKind: [[ARXType typeOfValueRef: _valueRef] typeKind]] alloc] initWithValueRef: _valueRef name: @""] autorelease];
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


-(ARXType *)type {
	return [ARXType typeWithTypeRef: LLVMTypeOf(self.valueRef)];
}


-(ARXBlock *)parentBlock {
	return [ARXBlock blockWithBlockRef: LLVMGetInstructionParent(self.valueRef)];
}

-(ARXModule *)module {
	return self.parentBlock.parentFunction.module;
}

-(ARXContext *)context {
	return self.module.context;
}


-(ARXBuilder *)builder {
	return self.module.builder;
}


-(ARXBooleanValue *)equals:(ARXValue *)other {
	return [self.builder equal: self, other];
}

-(ARXBooleanValue *)notEquals:(ARXValue *)other {
	return [self.builder notEqual: self, other];
}


-(ARXValue *)plus:(ARXValue *)other {
	return [self.builder add: self, other];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
