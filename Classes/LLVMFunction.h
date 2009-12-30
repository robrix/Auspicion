// LLVMFunction.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMValue.h"

@class LLVMModule, LLVMType;

@interface LLVMFunction : LLVMValue

+(id)functionInModule:(LLVMModule *)module withName:(NSString *)name type:(LLVMType *)type;

-(LLVMValue *)argumentValueAtIndex:(NSUInteger)index;

-(BOOL)verifyWithError:(NSError **)error;

@end