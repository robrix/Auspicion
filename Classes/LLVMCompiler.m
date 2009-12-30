// LLVMCompiler.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "LLVMCompiler.h"
#import "LLVMConcreteCompiler.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteModule.h"
#import "LLVMConcreteValue.h"

@implementation LLVMCompiler

+(id)compilerWithContext:(LLVMContext *)context {
	return [[[LLVMConcreteCompiler alloc] initWithContext: context] autorelease];
}


-(LLVMExecutionEngineRef)compilerRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


-(void *)compiledFunction:(LLVMFunction *)function {
	NSParameterAssert(function != nil);
	return AuspicionLLVMGetPointerToFunction(self.compilerRef, function.valueRef);
}


-(void)addModule:(LLVMModule *)module {
	LLVMAddModuleProvider(self.compilerRef, module.moduleProviderRef);
}

@end