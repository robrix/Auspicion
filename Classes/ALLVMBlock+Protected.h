// ALLVMBlock+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ALLVMBlock.h"

@interface ALLVMBlock ()

+(id)blockWithBlockRef:(LLVMBasicBlockRef)_blockRef;

@property (nonatomic, readonly) LLVMBasicBlockRef blockRef;

@end
