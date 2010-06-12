// ALLVMPointerValue.m
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ALLVMBuilder.h"
#import "ALLVMPointerValue.h"

@implementation ALLVMPointerValue

-(ALLVMValue *)value {
	return [self.builder get: self];
}

-(void)setValue:(ALLVMValue *)value {
	[self.builder set: self, value];
}

@end
