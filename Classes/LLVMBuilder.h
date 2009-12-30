// LLVMBuilder.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMContext, LLVMFunction, LLVMValue;

@interface LLVMBuilder : NSObject

+(LLVMBuilder *)builderWithContext:(LLVMContext *)context;

-(LLVMValue *)return:(LLVMValue *)value;

-(LLVMValue *)functionCall:(LLVMFunction *)function arguments:(NSArray *)arguments;

-(LLVMValue *)select:(LLVMValue *)condition then:(LLVMValue *)thenValue else:(LLVMValue *)elseValue;

-(LLVMValue *)add:(LLVMValue *)left and:(LLVMValue *)right;
-(LLVMValue *)not:(LLVMValue *)value;

@end