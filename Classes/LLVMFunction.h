// LLVMFunction.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Auspicion/LLVMValue.h>

@class LLVMContext, LLVMBlock, LLVMModule, LLVMType;

@interface LLVMFunction : LLVMValue

+(id)functionInModule:(LLVMModule *)module withName:(NSString *)name type:(LLVMType *)type;

@property (nonatomic, readonly) LLVMType *functionType;

@property (nonatomic, readonly) LLVMType *returnType;
@property (nonatomic, readonly) NSArray *argumentTypes;

@property (nonatomic, readonly) LLVMContext *context;
@property (nonatomic, readonly) LLVMModule *module;

-(LLVMValue *)parameterAtIndex:(NSUInteger)index;

-(BOOL)verifyWithError:(NSError **)error;

-(LLVMBlock *)appendBlockWithName:(NSString *)name;

@property (nonatomic, readonly) LLVMBlock *entryBlock;

@end
