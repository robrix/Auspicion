// LLVMOptimizer+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "LLVMOptimizer.h"

@interface LLVMOptimizer ()

-(id)initWithCompiler:(LLVMCompiler *)compiler;

@property (nonatomic, readonly) LLVMCompiler *compiler;
@property (nonatomic, readonly) LLVMPassManagerRef optimizerRef;

@end
