// LLVMType+Protected.h
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "LLVMType.h"

@interface LLVMType ()

@property (nonatomic, readonly) LLVMTypeRef typeRef;

+(id)typeWithTypeRef:(LLVMTypeRef)_typeRef;

+(id)typeOfValueRef:(LLVMValueRef)valueRef;

@property (nonatomic, readonly) LLVMTypeKind typeKind;

@end
