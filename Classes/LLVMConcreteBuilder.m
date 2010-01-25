// LLVMConcreteBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteBuilder.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteValue.h"

@implementation LLVMConcreteBuilder

-(id)initWithContext:(LLVMContext *)_context {
	if(self = [super init]) {
		builderRef = LLVMCreateBuilderInContext(_context.contextRef);
		context = [_context retain];
	}
	return self;
}


@synthesize builderRef;
@synthesize context;

@end
