// LLVMFunction.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMValue.h"

@interface LLVMFunction : LLVMValue

-(LLVMValue *)argumentValueAtIndex:(NSUInteger)index;

@end