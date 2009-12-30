// LLVMConcreteOptimizer.h
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMOptimizer.h"

@interface LLVMOptimizer ()

@property (nonatomic, readonly) LLVMCompiler *compiler;
@property (nonatomic, readonly) LLVMPassManagerRef optimizerRef;

@end


@interface LLVMConcreteOptimizer : LLVMOptimizer {
	LLVMCompiler *compiler;
	LLVMPassManagerRef optimizerRef;
}

-(id)initWithCompiler:(LLVMCompiler *)compiler;

@end