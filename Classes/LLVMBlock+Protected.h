// LLVMBlock+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "LLVMBlock.h"

@interface LLVMBlock ()

+(id)blockWithBlockRef:(LLVMBasicBlockRef)_blockRef;

@property (nonatomic, readonly) LLVMBasicBlockRef blockRef;

@end
