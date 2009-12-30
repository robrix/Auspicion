// LLVMBuilder.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMContext, LLVMFunction, LLVMValue;

@interface LLVMBuilder : NSObject

+(LLVMBuilder *)builderWithContext:(LLVMContext *)context;


-(void)positionAtEndOfFunction:(LLVMFunction *)function;

// I am not happy with these at all
-(LLVMValue *)return:(LLVMValue *)value;

-(LLVMValue *)call:(LLVMFunction *)function arguments:(NSArray *)arguments;
-(LLVMValue *)call:(LLVMFunction *)function argument:(LLVMValue *)argument;

-(LLVMValue *)condition:(LLVMValue *)condition then:(LLVMValue *)thenValue else:(LLVMValue *)elseValue;

-(LLVMValue *)add:(LLVMValue *)left to:(LLVMValue *)right;
-(LLVMValue *)not:(LLVMValue *)value;

-(LLVMValue *)stringPointer:(NSString *)string;

-(LLVMValue *)offsetPointer:(LLVMValue *)pointerValue by:(LLVMValue *)offsetValue;

-(LLVMValue *)valueIsTrue:(LLVMValue *)left andValueIsTrue:(LLVMValue *)right;

-(LLVMValue *)unsignedValue:(LLVMValue *)left isLessThanOrEqualTo:(LLVMValue *)right;
-(LLVMValue *)value:(LLVMValue *)left isEqualTo:(LLVMValue *)right;

@end