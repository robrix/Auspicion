// LLVMType.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

@class LLVMContext;

#import <Foundation/Foundation.h>

@interface LLVMType : NSObject

// integer type is 64-bit on __LP64__, 32-bit otherwise, just like NSInteger/NSUInteger
+(LLVMType *)integerTypeInContext:(LLVMContext *)context;

+(LLVMType *)int1TypeInContext:(LLVMContext *)context;
+(LLVMType *)int8TypeInContext:(LLVMContext *)context;
+(LLVMType *)int16TypeInContext:(LLVMContext *)context;
+(LLVMType *)int32TypeInContext:(LLVMContext *)context;
+(LLVMType *)int64TypeInContext:(LLVMContext *)context;

+(LLVMType *)pointerTypeInContext:(LLVMContext *)context toType:(LLVMType *)type addressSpace:(NSUInteger)addressSpace;

+(LLVMType *)functionTypeWithReturnType:(LLVMType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic;

@end