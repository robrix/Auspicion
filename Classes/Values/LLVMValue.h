// LLVMValue.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMBlock, LLVMBooleanValue, LLVMBuilder, LLVMContext, LLVMFunction, LLVMModule, LLVMType;

@interface LLVMValue : NSObject {
	struct LLVMOpaqueValue * valueRef;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, readonly) LLVMType *type;

@property (nonatomic, readonly) LLVMBlock *parentBlock;
@property (nonatomic, readonly) LLVMModule *module;
@property (nonatomic, readonly) LLVMContext *context;

@property (nonatomic, readonly) LLVMBuilder *builder;


-(LLVMBooleanValue *)equals:(LLVMValue *)other;
-(LLVMBooleanValue *)notEquals:(LLVMValue *)other;


-(LLVMValue *)plus:(LLVMValue *)other;

@end
