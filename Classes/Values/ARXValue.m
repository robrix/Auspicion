// ARXValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ARXBlock+Protected.h"
#import "ARXBuilder.h"
#import "ARXContext.h"
#import "ARXFunction.h"
#import "ARXFunctionType.h"
#import "ARXModule+Protected.h"
#import "ARXPointerType.h"
#import "ARXPointerValue.h"
#import "ARXStructureType.h"
#import "ARXStructureValue.h"
#import "ARXType+Protected.h"
#import "ARXValue+Protected.h"
#import "AuspicionLLVM.h"

@implementation ARXValue

-(id)initWithValueRef:(LLVMValueRef)_valueRef {
	if(self = [super init]) {
		valueRef = _valueRef;
		NSParameterAssert(valueRef != NULL);
	}
	return self;
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)_name {
	ARXValue *value = [self valueWithValueRef: _valueRef];
	value.name = [_name copy];
	return value;
}

+(id)valueWithValueRef:(LLVMValueRef)_valueRef {
	return [[[ARXType typeOfValueRef: _valueRef] correspondingValueClass] createUniqueInstanceForReference: _valueRef initializer: @selector(initWithValueRef:)];
}


@synthesize valueRef;


-(void)referencedByPointer:(ARXPointerValue *)pointer {
	referencingPointer = pointer;
}


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
	return self.isParameter
	?	nil
	:	[ARXBlock blockWithBlockRef: LLVMGetInstructionParent(self.valueRef)];
}

-(ARXFunction *)parentFunction {
	return self.isParameter
	?	[ARXFunction valueWithValueRef: LLVMGetParamParent(self.valueRef)]
	:	self.parentBlock.parentFunction;
}

-(ARXModule *)module {
	return self.isGlobal
	?	[ARXModule moduleWithModuleRef: LLVMGetGlobalParent(self.valueRef)]
	:	self.parentFunction.module;
}

-(ARXContext *)context {
	return self.module.context;
}


-(ARXBuilder *)builder {
	return self.module.builder;
}


@synthesize isParameter, isGlobal;


-(BOOL)isTerminator {
	return !!LLVMIsATerminatorInst(self.valueRef);
}


-(ARXBooleanValue *)equals:(ARXValue *)other {
	return [self.builder equal: self, other];
}

-(ARXBooleanValue *)notEquals:(ARXValue *)other {
	return [self.builder notEqual: self, other];
}


-(ARXBooleanValue *)isUnsignedLessThan:(ARXValue *)other {
	return [self.builder unsignedLessThan: self, other];
}


-(ARXBooleanValue *)invert {
	return [self.builder not: self];
}


-(ARXValue *)plus:(ARXValue *)other {
	return [self.builder add: self, other];
}


-(ARXBooleanValue *)toBoolean {
	return (ARXBooleanValue *)[self.builder castValue: self toType: self.context.int1Type];
}


-(NSString *)description {
	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
	free(bytes);
	return result;
}

@end
