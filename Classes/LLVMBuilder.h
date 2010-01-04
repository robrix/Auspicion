// LLVMBuilder.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMBlock, LLVMContext, LLVMFunction, LLVMType, LLVMValue;

/*
Unless otherwise noted (e.g. with NS_REQUIRES_NIL_TERMINATION), variadic builder methods take exactly two arguments. For example, -add: is used like so:

[builder add: left, right];
*/

@interface LLVMBuilder : NSObject

+(LLVMBuilder *)builderWithContext:(LLVMContext *)context;

@property (nonatomic, readonly) LLVMContext *context;

-(void)positionAtEndOfFunction:(LLVMFunction *)function;
-(void)positionAtEndOfBlock:(LLVMBlock *)block;

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
-(LLVMValue *)dereference:(LLVMValue *)pointer;

-(LLVMValue *)and:(LLVMValue *)left, ...;

-(LLVMValue *)unsignedLessOrEqual:(LLVMValue *)left, ...;
-(LLVMValue *)equal:(LLVMValue *)left, ...;
-(LLVMValue *)notEqual:(LLVMValue *)left, ...;

-(LLVMValue *)allocateLocal:(NSString *)name type:(LLVMType *)type;
-(LLVMValue *)setLocal:(LLVMValue *)local, ...;
-(LLVMValue *)getLocal:(LLVMValue *)local;

-(LLVMValue *)if:(LLVMValue *)condition then:(LLVMBlock *)thenBlock else:(LLVMBlock *)elseBlock;
-(LLVMValue *)jumpToBlock:(LLVMBlock *)block;

@end