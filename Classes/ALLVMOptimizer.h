// ALLVMOptimizer.h
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ALLVMCompiler, ALLVMModule;

@interface ALLVMOptimizer : NSObject {
	ALLVMCompiler *compiler;
	struct LLVMOpaquePassManager * optimizerRef;
}

+(id)optimizerWithCompiler:(ALLVMCompiler *)compiler;

-(void)addConstantPropagationPass;
-(void)addInstructionCombiningPass;
-(void)addPromoteMemoryToRegisterPass;
-(void)addGVNPass;
-(void)addCFGSimplificationPass;

// returns true if anything was optimized
-(BOOL)optimizeModule:(ALLVMModule *)module;

@end
