// LLVMConcreteFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteFunction.h"
#import "LLVMConcreteValue.h"

@implementation LLVMConcreteFunction

+(id)functionWithFunctionRef:(LLVMValueRef)_functionRef {
	return [[[self alloc] initWithFunctionRef: _functionRef] autorelease];
}

-(id)initWithFunctionRef:(LLVMValueRef)_functionRef {
	if(self = [super init]) {
		functionRef = _functionRef;
		NSParameterAssert(functionRef != NULL);
	}
	return self;
}


@synthesize functionRef;

@end
