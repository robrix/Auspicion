// ALLVMBuilder+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ALLVMBuilder.h"

@interface ALLVMBuilder ()

-(id)initWithContext:(ALLVMContext *)context;

@property (nonatomic, readonly) LLVMBuilderRef builderRef;

@end
