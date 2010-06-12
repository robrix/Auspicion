// ALLVMPointerValue.h
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ALLVMValue.h"

@interface ALLVMPointerValue : ALLVMValue

@property (nonatomic, copy) ALLVMValue *value;

@end
