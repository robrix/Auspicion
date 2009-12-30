// LLVMConcreteValue.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteValue.h"

@implementation LLVMConcreteValue

+(id)valueWithValueRef:(LLVMValueRef)_valueRef {
	return [[[self alloc] initWithValueRef: _valueRef] autorelease];
}

-(id)initWithValueRef:(LLVMValueRef)_valueRef {
	if(self = [super init]) {
		valueRef = _valueRef;
		NSParameterAssert(valueRef != NULL);
	}
	return self;
}

@synthesize valueRef;

@end