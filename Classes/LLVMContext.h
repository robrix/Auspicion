// LLVMContext.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class LLVMStructureType, LLVMType, LLVMValue;

@interface LLVMContext : NSObject {
	struct LLVMOpaqueContext * contextRef;
}

+(LLVMContext *)context;

// types
@property (nonatomic, readonly) LLVMType *integerType; // 64-bit on LP64, 32-bit otherwise
@property (nonatomic, readonly) LLVMType *int1Type;
@property (nonatomic, readonly) LLVMType *int8Type;
@property (nonatomic, readonly) LLVMType *int16Type;
@property (nonatomic, readonly) LLVMType *int32Type;
@property (nonatomic, readonly) LLVMType *int64Type;

@property (nonatomic, readonly) LLVMType *untypedPointerType;

@property (nonatomic, readonly) LLVMType *voidType;

-(LLVMStructureType *)structureTypeWithTypes:(LLVMType *)type, ... NS_REQUIRES_NIL_TERMINATION;


// constants
-(LLVMValue *)constantInteger:(NSInteger)integer;
-(LLVMValue *)constantUnsignedInteger:(NSUInteger)integer;
-(LLVMValue *)constantInt64:(int64_t)integer;
-(LLVMValue *)constantUnsignedInt64:(uint64_t)integer;
-(LLVMValue *)constantInt32:(int32_t)integer;
-(LLVMValue *)constantUnsignedInt32:(uint32_t)integer;

-(LLVMValue *)constantUntypedPointer:(void *)pointer;

-(LLVMValue *)constantNullOfType:(LLVMType *)type;

-(LLVMValue *)constantStructure:(LLVMValue *)value, ... NS_REQUIRES_NIL_TERMINATION;

@end
