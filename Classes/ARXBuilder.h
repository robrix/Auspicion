// ARXBuilder.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXBlock, ARXBooleanValue, ARXContext, ARXFunction, ARXPointerValue, ARXType, ARXValue;

/*
Unless otherwise noted (e.g. with NS_REQUIRES_NIL_TERMINATION), variadic builder methods take exactly two arguments. For example, -add: is used like so:

[builder add: left, right];
*/

@interface ARXBuilder : NSObject {
	struct LLVMOpaqueBuilder *builderRef;
	ARXContext *context;
}

+(ARXBuilder *)builderWithContext:(ARXContext *)context;

@property (nonatomic, readonly) ARXContext *context;

-(void)positionAtEndOfFunction:(ARXFunction *)function;
-(void)positionAtEndOfBlock:(ARXBlock *)block;

@property (nonatomic, readonly) ARXBlock *currentBlock;

-(ARXValue *)return:(ARXValue *)value;
-(ARXValue *)return;

-(ARXValue *)call:(ARXValue *)function arguments:(NSArray *)arguments;
-(ARXValue *)call:(ARXValue *)function argument:(ARXValue *)argument;
-(ARXValue *)call:(ARXValue *)function, ... NS_REQUIRES_NIL_TERMINATION;

-(ARXValue *)condition:(ARXValue *)condition then:(ARXValue *)thenValue else:(ARXValue *)elseValue;

-(ARXValue *)add:(ARXValue *)left, ...;
-(ARXValue *)subtract:(ARXValue *)left, ...;
-(ARXValue *)not:(ARXValue *)value;

-(ARXValue *)stringPointer:(NSString *)string;

// -(ARXValue *)offsetPointer:(ARXValue *)pointerValue by:(ARXValue *)offsetValue;
// -(ARXValue *)dereference:(ARXValue *)pointer;

-(ARXBooleanValue *)and:(ARXValue *)left, ...;
-(ARXBooleanValue *)or:(ARXValue *)left, ...;

-(ARXBooleanValue *)unsignedLessOrEqual:(ARXValue *)left, ...;
-(ARXBooleanValue *)unsignedLessThan:(ARXValue *)left, ...;
-(ARXBooleanValue *)equal:(ARXValue *)left, ...;
-(ARXBooleanValue *)notEqual:(ARXValue *)left, ...;

-(ARXValue *)castValue:(ARXValue *)operand toType:(ARXType *)type;

-(ARXPointerValue *)allocateLocal:(NSString *)name type:(ARXType *)type;

-(ARXValue *)set:(ARXValue *)address, ...;
-(ARXValue *)setElements:(ARXValue *)address, ... NS_REQUIRES_NIL_TERMINATION;
-(ARXValue *)get:(ARXValue *)address;
-(ARXValue *)getElement:(ARXValue *)address atIndex:(NSUInteger)index;

-(ARXValue *)if:(ARXValue *)condition then:(ARXBlock *)thenBlock else:(ARXBlock *)elseBlock;
-(ARXValue *)goto:(ARXBlock *)block;

@end
