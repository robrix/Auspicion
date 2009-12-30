// LLVMType.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

@class LLVMContext;

@interface LLVMType : NSObject

+(LLVMType *)integerTypeInContext:(LLVMContext *)context;

+(LLVMType *)pointerInContext:(LLVMContext *)context toType:(LLVMType *)type addressSpace:(NSUInteger)addressSpace;

+(LLVMType *)functionTypeWithReturnType:(LLVMType *)_returnType argumentTypes:(NSArray *)argumentTypes variadic:(BOOL)variadic;

@end