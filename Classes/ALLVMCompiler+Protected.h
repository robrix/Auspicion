// ALLVMCompiler+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ALLVMCompiler.h"

@interface ALLVMCompiler ()

-(id)initWithContext:(ALLVMContext *)context;

@property (nonatomic, readonly) LLVMExecutionEngineRef compilerRef;

@end
