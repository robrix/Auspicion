// ALLVMContext.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ALLVMStructureType, ALLVMType, ALLVMValue;

@interface ALLVMContext : NSObject {
	struct LLVMOpaqueContext * contextRef;
}

+(ALLVMContext *)context;

// types
@property (nonatomic, readonly) ALLVMType *integerType; // 64-bit on LP64, 32-bit otherwise
@property (nonatomic, readonly) ALLVMType *int1Type;
@property (nonatomic, readonly) ALLVMType *int8Type;
@property (nonatomic, readonly) ALLVMType *int16Type;
@property (nonatomic, readonly) ALLVMType *int32Type;
@property (nonatomic, readonly) ALLVMType *int64Type;

@property (nonatomic, readonly) ALLVMType *untypedPointerType;

@property (nonatomic, readonly) ALLVMType *voidType;

-(ALLVMStructureType *)structureTypeWithTypes:(ALLVMType *)type, ... NS_REQUIRES_NIL_TERMINATION;


// constants
-(ALLVMValue *)constantInteger:(NSInteger)integer;
-(ALLVMValue *)constantUnsignedInteger:(NSUInteger)integer;
-(ALLVMValue *)constantInt64:(int64_t)integer;
-(ALLVMValue *)constantUnsignedInt64:(uint64_t)integer;
-(ALLVMValue *)constantInt32:(int32_t)integer;
-(ALLVMValue *)constantUnsignedInt32:(uint32_t)integer;

-(ALLVMValue *)constantUntypedPointer:(void *)pointer;

-(ALLVMValue *)constantNullOfType:(ALLVMType *)type;

-(ALLVMValue *)constantStructure:(ALLVMValue *)value, ... NS_REQUIRES_NIL_TERMINATION;

@end
