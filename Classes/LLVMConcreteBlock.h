// LLVMConcreteBlock.h
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import "LLVMBlock.h"

@interface LLVMBlock ()

@property (nonatomic, readonly) LLVMBasicBlockRef blockRef;

@end


@interface LLVMConcreteBlock : LLVMBlock {
	LLVMBasicBlockRef blockRef;
}

+(id)blockWithBlockRef:(LLVMBasicBlockRef)_blockRef;
-(id)initWithBlockRef:(LLVMBasicBlockRef)_blockRef;

@end