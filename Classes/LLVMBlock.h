// LLVMBlock.h
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMFunction;

@interface LLVMBlock : NSObject {
	LLVMBasicBlockRef blockRef;
}

@property (nonatomic, readonly) LLVMFunction *parentFunction;

@end
