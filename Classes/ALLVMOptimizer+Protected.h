// ALLVMOptimizer+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ALLVMOptimizer.h"

@interface ALLVMOptimizer ()

-(id)initWithCompiler:(ALLVMCompiler *)compiler;

@property (nonatomic, readonly) ALLVMCompiler *compiler;
@property (nonatomic, readonly) LLVMPassManagerRef optimizerRef;

@end
