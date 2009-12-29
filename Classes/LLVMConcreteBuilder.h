// LLVMConcreteBuilder.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMBuilder.h"

@interface LLVMConcreteBuilder : LLVMBuilder {
	LLVMBuilderRef builderRef;
}

-(id)initWithContext:(LLVMContext *)context;

@end