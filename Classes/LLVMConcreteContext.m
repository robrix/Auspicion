// LLVMConcreteContext.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteContext.h"

@implementation LLVMConcreteContext

-(id)initWithContextRef:(LLVMContextRef)_contextRef {
	if(self = [super init]) {
		contextRef = _contextRef;
	}
	return self;
}

@synthesize contextRef;

@end
