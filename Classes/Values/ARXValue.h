// ARXValue.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXBlock, ARXBooleanValue, ARXBuilder, ARXContext, ARXFunction, ARXModule, ARXType;

@interface ARXValue : NSObject {
	struct LLVMOpaqueValue * valueRef;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, readonly) ARXType *type;

@property (nonatomic, readonly) ARXBlock *parentBlock;
@property (nonatomic, readonly) ARXModule *module;
@property (nonatomic, readonly) ARXContext *context;

@property (nonatomic, readonly) ARXBuilder *builder;


-(ARXBooleanValue *)equals:(ARXValue *)other;
-(ARXBooleanValue *)notEquals:(ARXValue *)other;


-(ARXValue *)plus:(ARXValue *)other;

@end
