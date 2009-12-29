// LLVMModule.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMContext, LLVMFunction;

@interface LLVMModule : NSObject

+(LLVMModule *)moduleWithName:(NSString *)_name inContext:(LLVMContext *)context;

-(LLVMFunction *)functionWithName:(NSString *)_name;

@end