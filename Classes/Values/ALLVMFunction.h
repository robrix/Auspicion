// ALLVMFunction.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "ALLVMValue.h"

@class ALLVMContext, ALLVMBlock, ALLVMFunctionType, ALLVMModule, ALLVMType;

@interface ALLVMFunction : ALLVMValue

+(id)functionInModule:(ALLVMModule *)module withName:(NSString *)name type:(ALLVMType *)type;

@property (nonatomic, readonly) ALLVMFunctionType *functionType;

@property (nonatomic, readonly) ALLVMContext *context;
@property (nonatomic, readonly) ALLVMModule *module;

-(ALLVMValue *)argumentAtIndex:(NSUInteger)index;
-(ALLVMValue *)argumentNamed:(NSString *)name;

-(BOOL)verifyWithError:(NSError **)error;

-(ALLVMBlock *)appendBlockWithName:(NSString *)name;

@property (nonatomic, readonly) ALLVMBlock *entryBlock;

-(ALLVMValue *)call:(ALLVMValue *)arg, ...;

@end
