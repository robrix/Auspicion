// LLVMBlock.m
// Created by Rob Rix on 2010-01-03
// Copyright 2010 Monochrome Industries

#import "LLVMBlock.h"

@implementation LLVMBlock

-(LLVMBasicBlockRef)blockRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}

@end
