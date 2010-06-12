// ARXCompiler+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ARXCompiler.h"

@interface ARXCompiler ()

-(id)initWithContext:(ARXContext *)context;

@property (nonatomic, readonly) LLVMExecutionEngineRef compilerRef;

@end
