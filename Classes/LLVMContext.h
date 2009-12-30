// LLVMContext.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMType;

@interface LLVMContext : NSObject

// returns a shared global context
+(LLVMContext *)sharedContext;

// returns a new private context
+(LLVMContext *)context;

// types
@property (nonatomic, readonly) LLVMType *integerType; // 64-bit on LP64, 32-bit otherwise
@property (nonatomic, readonly) LLVMType *int1Type;
@property (nonatomic, readonly) LLVMType *int8Type;
@property (nonatomic, readonly) LLVMType *int16Type;
@property (nonatomic, readonly) LLVMType *int32Type;
@property (nonatomic, readonly) LLVMType *int64Type;

-(LLVMType *)untypedPointerType;

// constants
-(LLVMValue *)constantInteger:(NSInteger)integer;
-(LLVMValue *)constantUnsignedInteger:(NSUInteger)integer;
-(LLVMValue *)constantInt32:(int32_t)integer;
-(LLVMValue *)constantUnsignedInt32:(uint32_t)integer;

@end