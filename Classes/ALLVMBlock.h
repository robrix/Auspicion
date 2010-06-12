// ALLVMBlock.h
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

@class ALLVMFunction;

@interface ALLVMBlock : NSObject {
	struct LLVMOpaqueBasicBlock * blockRef;
}

@property (nonatomic, readonly) ALLVMFunction *parentFunction;

@end
