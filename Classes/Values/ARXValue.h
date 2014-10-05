// ARXValue.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXBlock, ARXBooleanValue, ARXBuilder, ARXContext, ARXFunction, ARXModule, ARXPointerValue, ARXType;

@interface ARXValue : NSObject {
	struct LLVMOpaqueValue * valueRef;
	ARXPointerValue *referencingPointer;
	BOOL isParameter;
	BOOL isGlobal;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, readonly) ARXType *type;

@property (nonatomic, readonly) ARXBlock *parentBlock;
@property (nonatomic, readonly) ARXModule *module;
@property (nonatomic, readonly) ARXContext *context;

@property (nonatomic, readonly) ARXBuilder *builder;

@property (nonatomic, assign) BOOL isParameter;
@property (nonatomic, assign) BOOL isGlobal;

@property (nonatomic, readonly) BOOL isTerminator; // and thus will be back

-(ARXBooleanValue *)equals:(ARXValue *)other;
-(ARXBooleanValue *)notEquals:(ARXValue *)other;

-(ARXBooleanValue *)isUnsignedLessThan:(ARXValue *)other;

-(ARXBooleanValue *)invert;

-(ARXValue *)plus:(ARXValue *)other;

-(ARXBooleanValue *)toBoolean;

@end
