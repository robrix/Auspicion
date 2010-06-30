// ARXContext.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import <Foundation/Foundation.h>

@class ARXStructureType, ARXStructureValue, ARXType, ARXValue;

@interface ARXContext : NSObject {
	struct LLVMOpaqueContext * contextRef;
}

+(ARXContext *)context;

// types
@property (nonatomic, readonly) ARXType *integerType; // 64-bit on LP64, 32-bit otherwise
@property (nonatomic, readonly) ARXType *int1Type;
@property (nonatomic, readonly) ARXType *int8Type;
@property (nonatomic, readonly) ARXType *int16Type;
@property (nonatomic, readonly) ARXType *int32Type;
@property (nonatomic, readonly) ARXType *int64Type;

@property (nonatomic, readonly) ARXType *untypedPointerType;

@property (nonatomic, readonly) ARXType *voidType;

-(ARXStructureType *)structureTypeWithTypes:(ARXType *)type, ... NS_REQUIRES_NIL_TERMINATION;


// constants
-(ARXValue *)constantInteger:(NSInteger)integer;
-(ARXValue *)constantUnsignedInteger:(NSUInteger)integer;
-(ARXValue *)constantInt64:(int64_t)integer;
-(ARXValue *)constantUnsignedInt64:(uint64_t)integer;
-(ARXValue *)constantInt32:(int32_t)integer;
-(ARXValue *)constantUnsignedInt32:(uint32_t)integer;

-(ARXValue *)constantUntypedPointer:(void *)pointer;
-(ARXValue *)constantPointer:(void *)pointer ofType:(ARXType *)type;

-(ARXValue *)constantNullOfType:(ARXType *)type;

-(ARXStructureValue *)constantStructure:(ARXValue *)value, ... NS_REQUIRES_NIL_TERMINATION;

@end
