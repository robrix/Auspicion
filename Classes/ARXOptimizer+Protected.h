// ARXOptimizer+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ARXOptimizer.h"

@interface ARXOptimizer ()

-(id)initWithCompiler:(ARXCompiler *)compiler;

@property (nonatomic, readonly) ARXCompiler *compiler;
@property (nonatomic, readonly) LLVMPassManagerRef optimizerRef;

@end
