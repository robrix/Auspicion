// LLVMValue+Protected.m
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "LLVMValue.h"

@interface LLVMValue ()

@property (nonatomic, readonly) LLVMValueRef valueRef;

+(id)valueWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)name;
+(id)valueWithValueRef:(LLVMValueRef)_valueRef;
-(id)initWithValueRef:(LLVMValueRef)_valueRef name:(NSString *)name;

@end