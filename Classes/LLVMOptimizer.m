// LLVMOptimizer.m
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMConcreteModule.h"
#import "LLVMConcreteOptimizer.h"
#import "LLVMOptimizer.h"

@implementation LLVMOptimizer

+(id)optimizerWithCompiler:(LLVMCompiler *)compiler {
	return [[[LLVMConcreteOptimizer alloc] initWithCompiler: compiler] autorelease];
}


-(LLVMCompiler *)compiler {
	[self doesNotRecognizeSelector: _cmd];
	return nil;
}

-(LLVMPassManagerRef)optimizerRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


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
