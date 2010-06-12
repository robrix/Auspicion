// LLVMBuilder+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "LLVMBuilder.h"

@interface LLVMBuilder ()

-(id)initWithContext:(LLVMContext *)context;

@property (nonatomic, readonly) LLVMBuilderRef builderRef;

@end
