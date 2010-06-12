// LLVMBooleanValue.m
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "LLVMBlock.h"
#import "LLVMBooleanValue.h"
#import "LLVMBuilder.h"
#import "LLVMFunction.h"

@implementation LLVMBooleanValue

-(void)ifTrue:(void(^)())block {
	LLVMBlock
		*thenBlock = [self.parentBlock.parentFunction appendBlockWithName: [NSString stringWithFormat: @"%@ ifTrue", self.description]],
		*postBlock = [self.parentBlock.parentFunction appendBlockWithName: [NSString stringWithFormat: @"%@ post", self.description]];
	[self.builder if: self then: thenBlock else: postBlock];
	
	[self.builder positionAtEndOfBlock: thenBlock];
	block();
	[self.builder jumpToBlock: postBlock];
	[self.builder positionAtEndOfBlock: postBlock];
}


-(LLVMValue *)select:(LLVMValue *)either or:(LLVMValue *)or {
	return [self.builder condition: self then: either else: or];
}

@end
