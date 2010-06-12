// LLVMStructureValue.h
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "LLVMValue.h"

@class LLVMPointerValue, LLVMStructureType;

@interface LLVMStructureValue : LLVMValue

-(LLVMPointerValue *)referenceToElementAtIndex:(NSUInteger)i;
-(LLVMValue *)elementAtIndex:(NSUInteger)i;

-(LLVMValue *)elementNamed:(NSString *)name;

@property (nonatomic, copy) NSArray *elements;

@property (nonatomic, readonly) LLVMStructureType *structureType;

@end
