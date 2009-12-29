// LLVMContext.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@interface LLVMContext : NSObject

// returns a shared global context
+(LLVMContext *)sharedContext;

// returns a new private context
+(LLVMContext *)context;

@end