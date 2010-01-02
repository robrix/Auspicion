// LLVMBuilder.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMContext, LLVMFunction, LLVMValue;

/*
Unless otherwise noted (e.g. with NS_REQUIRES_NIL_TERMINATION), variadic builder methods take exactly two arguments. For example, -add: is used like so:

[builder add: left, right];
*/

@interface LLVMBuilder : NSObject

+(LLVMBuilder *)builderWithContext:(LLVMContext *)context;

-(void)positionAtEndOfFunction:(LLVMFunction *)function;

// can these be improved upon?
-(LLVMValue *)return:(LLVMValue *)value;

-(LLVMValue *)call:(LLVMFunction *)function arguments:(NSArray *)arguments;
-(LLVMValue *)call:(LLVMFunction *)function argument:(LLVMValue *)argument;
-(LLVMValue *)call:(LLVMFunction *)function, ... NS_REQUIRES_NIL_TERMINATION;

-(LLVMValue *)condition:(LLVMValue *)condition then:(LLVMValue *)thenValue else:(LLVMValue *)elseValue;

-(LLVMValue *)add:(LLVMValue *)left, ...;
-(LLVMValue *)not:(LLVMValue *)value;

-(LLVMValue *)stringPointer:(NSString *)string;

// -(LLVMValue *)offsetPointer:(LLVMValue *)pointerValue by:(LLVMValue *)offsetValue;

-(LLVMValue *)and:(LLVMValue *)left, ...;

-(LLVMValue *)unsignedLessOrEqual:(LLVMValue *)left, ...;
-(LLVMValue *)equal:(LLVMValue *)left, ...;
-(LLVMValue *)notEqual:(LLVMValue *)left, ...;

@end