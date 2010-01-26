// LLVMConcreteCompiler.h
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMCompiler.h"

@interface LLVMCompiler ()

@property (nonatomic, readonly) LLVMExecutionEngineRef compilerRef;

@end


@interface LLVMConcreteCompiler : LLVMCompiler {
	LLVMModuleProviderRef moduleProviderRef;
	LLVMExecutionEngineRef compilerRef;
}

-(id)initWithContext:(LLVMContext *)context;

@end
