// ALLVMValue.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ALLVMBlock, ALLVMBooleanValue, ALLVMBuilder, ALLVMContext, ALLVMFunction, ALLVMModule, ALLVMType;

@interface ALLVMValue : NSObject {
	struct LLVMOpaqueValue * valueRef;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, readonly) ALLVMType *type;

@property (nonatomic, readonly) ALLVMBlock *parentBlock;
@property (nonatomic, readonly) ALLVMModule *module;
@property (nonatomic, readonly) ALLVMContext *context;

@property (nonatomic, readonly) ALLVMBuilder *builder;


-(ALLVMBooleanValue *)equals:(ALLVMValue *)other;
-(ALLVMBooleanValue *)notEquals:(ALLVMValue *)other;


-(ALLVMValue *)plus:(ALLVMValue *)other;

@end
