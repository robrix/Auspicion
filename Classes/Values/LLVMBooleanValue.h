// LLVMBooleanValue.h
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "LLVMValue.h"

@interface LLVMBooleanValue : LLVMValue

-(void)ifTrue:(void(^)())block;

-(LLVMValue *)select:(LLVMValue *)either or:(LLVMValue *)or;

@end
