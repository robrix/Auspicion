// LLVMOptimizer.m
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMCompiler+Protected.h"
#import "LLVMModule+Protected.h"
#import "LLVMOptimizer+Protected.h"

@implementation LLVMOptimizer

+(id)optimizerWithCompiler:(LLVMCompiler *)compiler {
	return [[[self alloc] initWithCompiler: compiler] autorelease];
}

-(id)initWithCompiler:(LLVMCompiler *)_compiler {
	if(self = [super init]) {
		compiler = [_compiler retain];
		NSParameterAssert(compiler != nil);
		optimizerRef = LLVMCreatePassManager();
		LLVMAddTargetData(LLVMGetExecutionEngineTargetData(compiler.compilerRef), optimizerRef);
	}
	return self;
}

-(void)dealloc {
	[compiler release];
	LLVMDisposePassManager(optimizerRef);
	[super dealloc];
}


@synthesize compiler, optimizerRef;


-(void)addConstantPropagationPass {
	LLVMAddConstantPropagationPass(self.optimizerRef);
}

-(void)addInstructionCombiningPass {
	LLVMAddInstructionCombiningPass(self.optimizerRef);
}

-(void)addPromoteMemoryToRegisterPass {
	LLVMAddPromoteMemoryToRegisterPass(self.optimizerRef);
}

-(void)addGVNPass {
	LLVMAddGVNPass(self.optimizerRef);
}

-(void)addCFGSimplificationPass {
	LLVMAddCFGSimplificationPass(self.optimizerRef);
}


-(BOOL)optimizeModule:(LLVMModule *)module {
	return LLVMRunPassManager(self.optimizerRef, module.moduleRef);
}

@end
