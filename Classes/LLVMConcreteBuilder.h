// LLVMConcreteBuilder.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMBuilder.h"

@interface LLVMBuilder ()

@property (nonatomic, readonly) LLVMBuilderRef builderRef;

@end


@interface LLVMConcreteBuilder : LLVMBuilder {
	LLVMBuilderRef builderRef;
	LLVMContext *context;
}

-(id)initWithContext:(LLVMContext *)context;

@end
