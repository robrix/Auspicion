// LLVMConcreteOptimizer.m
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteCompiler.h"
#import "LLVMConcreteOptimizer.h"

@implementation LLVMConcreteOptimizer

-(id)initWithCompiler:(LLVMCompiler *)_compiler {
	if(self = [super init]) {
		compiler = [_compiler retain];
		NSParameterAssert(compiler != nil);
		LLVMAddTargetData(LLVMGetExecutionEngineTargetData(compiler.compilerRef), optimizerRef);
	}
	return self;
}

-(void)dealloc {
	[compiler release];
	[super dealloc];
}


@synthesize compiler;

@synthesize optimizerRef;

@end