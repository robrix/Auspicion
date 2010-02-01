// LLVMConcreteFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteFunction.h"
#import "LLVMConcreteValue.h"

@implementation LLVMConcreteFunction

+(id)functionWithFunctionRef:(LLVMValueRef)_functionRef inModule:(LLVMModule *)module {
	return [[[self alloc] initWithFunctionRef: _functionRef inModule: module] autorelease];
}

-(id)initWithFunctionRef:(LLVMValueRef)_functionRef inModule:(LLVMModule *)_module {
	if(self = [super init]) {
		functionRef = _functionRef;
		NSParameterAssert(functionRef != NULL);
		module = [_module retain];
		NSParameterAssert(module != nil);
	}
	return self;
}


@synthesize functionRef;

@synthesize module;

@end
