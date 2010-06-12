// ARXBlock.h
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXFunction;

@interface ARXBlock : NSObject {
	struct LLVMOpaqueBasicBlock * blockRef;
}

@property (nonatomic, readonly) ARXFunction *parentFunction;

@end
