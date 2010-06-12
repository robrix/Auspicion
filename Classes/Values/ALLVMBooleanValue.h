// ALLVMBooleanValue.h
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ALLVMValue.h"

@interface ALLVMBooleanValue : ALLVMValue

-(void)ifTrue:(void(^)())block;

-(ALLVMValue *)select:(ALLVMValue *)either or:(ALLVMValue *)or;

@end
