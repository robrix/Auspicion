// ARXBuilder+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ARXBuilder.h"

@interface ARXBuilder ()

-(id)initWithContext:(ARXContext *)context;

@property (nonatomic, readonly) LLVMBuilderRef builderRef;

@end
