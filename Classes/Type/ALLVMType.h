// ALLVMType.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

@class ALLVMContext, ALLVMStructureType;

#import <Foundation/Foundation.h>

@interface ALLVMType : NSObject {
	struct LLVMOpaqueType * typeRef;
}

// integer type is 64-bit on __LP64__, 32-bit otherwise, just like NSInteger/NSUInteger
+(ALLVMType *)integerTypeInContext:(ALLVMContext *)context;

+(ALLVMType *)int1TypeInContext:(ALLVMContext *)context;
+(ALLVMType *)int8TypeInContext:(ALLVMContext *)context;
+(ALLVMType *)int16TypeInContext:(ALLVMContext *)context;
+(ALLVMType *)int32TypeInContext:(ALLVMContext *)context;
+(ALLVMType *)int64TypeInContext:(ALLVMContext *)context;

+(ALLVMType *)floatTypeInContext:(ALLVMContext *)context;
+(ALLVMType *)doubleTypeInContext:(ALLVMContext *)context;

+(ALLVMType *)pointerTypeToType:(ALLVMType *)type addressSpace:(NSUInteger)addressSpace;
+(ALLVMType *)pointerTypeToType:(ALLVMType *)type; // implied address space of 0
+(ALLVMType *)untypedPointerTypeInContext:(ALLVMContext *)context; // implied address space of 0, destination type of int8

+(ALLVMType *)voidTypeInContext:(ALLVMContext *)context;

+(ALLVMType *)functionTypeWithReturnType:(ALLVMType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic;
+(ALLVMType *)functionType:(ALLVMType *)_returnType, ... NS_REQUIRES_NIL_TERMINATION; // implied non-variadic

+(ALLVMType *)arrayTypeWithCount:(NSUInteger)count type:(ALLVMType *)type;
+(ALLVMStructureType *)structureTypeWithTypes:(NSArray *)types;
+(ALLVMStructureType *)structureTypeInContext:(ALLVMContext *)context withTypes:(NSArray *)types;
+(ALLVMType *)unionTypeWithTypes:(NSArray *)types;

@property (nonatomic, readonly) ALLVMContext *context;

@end
