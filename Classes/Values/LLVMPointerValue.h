// LLVMPointerValue.h
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "LLVMValue.h"

@interface LLVMPointerValue : LLVMValue

@property (nonatomic, copy) LLVMValue *value;

@end
