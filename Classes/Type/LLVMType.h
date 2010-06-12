// LLVMType.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

@class LLVMContext, LLVMStructureType;

#import <Foundation/Foundation.h>

@interface LLVMType : NSObject {
	struct LLVMOpaqueType * typeRef;
}

// integer type is 64-bit on __LP64__, 32-bit otherwise, just like NSInteger/NSUInteger
+(LLVMType *)integerTypeInContext:(LLVMContext *)context;

+(LLVMType *)int1TypeInContext:(LLVMContext *)context;
+(LLVMType *)int8TypeInContext:(LLVMContext *)context;
+(LLVMType *)int16TypeInContext:(LLVMContext *)context;
+(LLVMType *)int32TypeInContext:(LLVMContext *)context;
+(LLVMType *)int64TypeInContext:(LLVMContext *)context;

+(LLVMType *)floatTypeInContext:(LLVMContext *)context;
+(LLVMType *)doubleTypeInContext:(LLVMContext *)context;

+(LLVMType *)pointerTypeToType:(LLVMType *)type addressSpace:(NSUInteger)addressSpace;
+(LLVMType *)pointerTypeToType:(LLVMType *)type; // implied address space of 0
+(LLVMType *)untypedPointerTypeInContext:(LLVMContext *)context; // implied address space of 0, destination type of int8

+(LLVMType *)voidTypeInContext:(LLVMContext *)context;

+(LLVMType *)functionTypeWithReturnType:(LLVMType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic;
+(LLVMType *)functionType:(LLVMType *)_returnType, ... NS_REQUIRES_NIL_TERMINATION; // implied non-variadic

+(LLVMType *)arrayTypeWithCount:(NSUInteger)count type:(LLVMType *)type;
+(LLVMStructureType *)structureTypeWithTypes:(NSArray *)types;
+(LLVMStructureType *)structureTypeInContext:(LLVMContext *)context withTypes:(NSArray *)types;
+(LLVMType *)unionTypeWithTypes:(NSArray *)types;

@property (nonatomic, readonly) LLVMContext *context;

@end
