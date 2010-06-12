// ALLVMStructureValue.h
// Created by Rob Rix on 2010-06-10
// Copyright 2010 Monochrome Industries

#import "ALLVMValue.h"

@class ALLVMPointerValue, ALLVMStructureType;

@interface ALLVMStructureValue : ALLVMValue

-(ALLVMPointerValue *)referenceToElementAtIndex:(NSUInteger)i;
-(ALLVMValue *)elementAtIndex:(NSUInteger)i;

-(ALLVMValue *)elementNamed:(NSString *)name;

@property (nonatomic, copy) NSArray *elements;

@property (nonatomic, readonly) ALLVMStructureType *structureType;

@end
