// LLVMConcreteBuilder.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteBuilder.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteValue.h"

@implementation LLVMConcreteBuilder

-(id)initWithContext:(LLVMContext *)context {
	if(self = [super init]) {
		builderRef = LLVMCreateBuilderInContext(context.contextRef);
	}
	return self;
}


@synthesize builderRef;

@end