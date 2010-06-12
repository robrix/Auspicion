// LLVMCompiler+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "LLVMCompiler.h"

@interface LLVMCompiler ()

-(id)initWithContext:(LLVMContext *)context;

@property (nonatomic, readonly) LLVMExecutionEngineRef compilerRef;

@end
