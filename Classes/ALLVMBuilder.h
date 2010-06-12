// ALLVMBuilder.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ALLVMBlock, ALLVMBooleanValue, ALLVMContext, ALLVMFunction, ALLVMPointerValue, ALLVMType, ALLVMValue;

/*
Unless otherwise noted (e.g. with NS_REQUIRES_NIL_TERMINATION), variadic builder methods take exactly two arguments. For example, -add: is used like so:

[builder add: left, right];
*/

@interface ALLVMBuilder : NSObject {
	struct LLVMOpaqueBuilder *builderRef;
	ALLVMContext *context;
}

+(ALLVMBuilder *)builderWithContext:(ALLVMContext *)context;

@property (nonatomic, readonly) ALLVMContext *context;

-(void)positionAtEndOfFunction:(ALLVMFunction *)function;
-(void)positionAtEndOfBlock:(ALLVMBlock *)block;

// can these be improved upon?
-(ALLVMValue *)return:(ALLVMValue *)value;

-(ALLVMValue *)call:(ALLVMValue *)function arguments:(NSArray *)arguments;
-(ALLVMValue *)call:(ALLVMValue *)function argument:(ALLVMValue *)argument;
-(ALLVMValue *)call:(ALLVMValue *)function, ... NS_REQUIRES_NIL_TERMINATION;

-(ALLVMValue *)condition:(ALLVMValue *)condition then:(ALLVMValue *)thenValue else:(ALLVMValue *)elseValue;

-(ALLVMValue *)add:(ALLVMValue *)left, ...;
-(ALLVMValue *)subtract:(ALLVMValue *)left, ...;
-(ALLVMValue *)not:(ALLVMValue *)value;

-(ALLVMValue *)stringPointer:(NSString *)string;

// -(ALLVMValue *)offsetPointer:(ALLVMValue *)pointerValue by:(ALLVMValue *)offsetValue;
// -(ALLVMValue *)dereference:(ALLVMValue *)pointer;

-(ALLVMBooleanValue *)and:(ALLVMValue *)left, ...;
-(ALLVMBooleanValue *)or:(ALLVMValue *)left, ...;

-(ALLVMBooleanValue *)unsignedLessOrEqual:(ALLVMValue *)left, ...;
-(ALLVMBooleanValue *)unsignedLessThan:(ALLVMValue *)left, ...;
-(ALLVMBooleanValue *)equal:(ALLVMValue *)left, ...;
-(ALLVMBooleanValue *)notEqual:(ALLVMValue *)left, ...;

-(ALLVMPointerValue *)allocateLocal:(NSString *)name type:(ALLVMType *)type;

-(ALLVMValue *)set:(ALLVMValue *)address, ...;
-(ALLVMValue *)setElements:(ALLVMValue *)address, ... NS_REQUIRES_NIL_TERMINATION;
-(ALLVMValue *)get:(ALLVMValue *)address;
-(ALLVMValue *)getElement:(ALLVMValue *)address atIndex:(NSUInteger)index;

-(ALLVMValue *)if:(ALLVMValue *)condition then:(ALLVMBlock *)thenBlock else:(ALLVMBlock *)elseBlock;
-(ALLVMValue *)jumpToBlock:(ALLVMBlock *)block;

@end
