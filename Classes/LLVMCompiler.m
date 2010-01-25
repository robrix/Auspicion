// LLVMCompiler.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "LLVMCompiler.h"
#import "LLVMConcreteCompiler.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteModule.h"
#import "LLVMConcreteValue.h"
#import "LLVMContext.h"

@implementation LLVMCompiler

+(id)sharedCompiler {
	static LLVMCompiler *sharedCompiler = nil;
	if(!sharedCompiler) {
		sharedCompiler = [[self compilerWithContext: [LLVMContext sharedContext]] retain];
	}
	return sharedCompiler;
}

+(id)compilerWithContext:(LLVMContext *)context {
	return [[[LLVMConcreteCompiler alloc] initWithContext: context] autorelease];
}


-(LLVMExecutionEngineRef)compilerRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


-(void *)compiledFunction:(LLVMFunction *)function {
	NSParameterAssert(function != nil);
	return AuspicionLLVMGetPointerToFunction(self.compilerRef, function.functionRef);
}


-(void)addModule:(LLVMModule *)module {
	LLVMAddModuleProvider(self.compilerRef, module.moduleProviderRef);
}

@end
