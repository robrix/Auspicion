// LLVMValue.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMType;

@interface LLVMValue : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, readonly) LLVMType *type;

@end
