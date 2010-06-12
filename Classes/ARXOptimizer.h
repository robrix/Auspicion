// ARXOptimizer.h
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXCompiler, ARXModule;

@interface ARXOptimizer : NSObject {
	ARXCompiler *compiler;
	struct LLVMOpaquePassManager * optimizerRef;
}

+(id)optimizerWithCompiler:(ARXCompiler *)compiler;

-(void)addConstantPropagationPass;
-(void)addInstructionCombiningPass;
-(void)addPromoteMemoryToRegisterPass;
-(void)addGVNPass;
-(void)addCFGSimplificationPass;

// returns true if anything was optimized
-(BOOL)optimizeModule:(ARXModule *)module;

@end
