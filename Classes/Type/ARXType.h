// ARXType.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

@class ARXContext, ARXFunctionType, ARXStructureType;

#import <Foundation/Foundation.h>

@interface ARXType : NSObject {
	struct LLVMOpaqueType * typeRef;
}

// integer type is 64-bit on __LP64__, 32-bit otherwise, just like NSInteger/NSUInteger
+(ARXType *)integerTypeInContext:(ARXContext *)context;

+(ARXType *)int1TypeInContext:(ARXContext *)context;
+(ARXType *)int8TypeInContext:(ARXContext *)context;
+(ARXType *)int16TypeInContext:(ARXContext *)context;
+(ARXType *)int32TypeInContext:(ARXContext *)context;
+(ARXType *)int64TypeInContext:(ARXContext *)context;

+(ARXType *)floatTypeInContext:(ARXContext *)context;
+(ARXType *)doubleTypeInContext:(ARXContext *)context;

+(ARXType *)pointerTypeToType:(ARXType *)type addressSpace:(NSUInteger)addressSpace;
+(ARXType *)pointerTypeToType:(ARXType *)type; // implied address space of 0
+(ARXType *)untypedPointerTypeInContext:(ARXContext *)context; // implied address space of 0, destination type of int8

+(ARXType *)voidTypeInContext:(ARXContext *)context;

+(ARXFunctionType *)functionTypeWithReturnType:(ARXType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic;
+(ARXFunctionType *)functionType:(ARXType *)_returnType, ... NS_REQUIRES_NIL_TERMINATION; // implied non-variadic

+(ARXType *)arrayTypeWithCount:(NSUInteger)count type:(ARXType *)type;
+(ARXStructureType *)structureTypeWithTypes:(NSArray *)types;
+(ARXStructureType *)structureTypeWithTypes:(NSArray *)types inContext:(ARXContext *)context;
+(ARXType *)unionTypeWithTypes:(NSArray *)types;

@property (nonatomic, readonly) ARXContext *context;

@property (nonatomic, readonly) Class correspondingValueClass;

@end
