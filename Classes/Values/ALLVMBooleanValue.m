// ALLVMBooleanValue.m
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ALLVMBlock.h"
#import "ALLVMBooleanValue.h"
#import "ALLVMBuilder.h"
#import "ALLVMFunction.h"

@implementation ALLVMBooleanValue

-(void)ifTrue:(void(^)())block {
	ALLVMBlock
		*thenBlock = [self.parentBlock.parentFunction appendBlockWithName: [NSString stringWithFormat: @"%@ ifTrue", self.description]],
		*postBlock = [self.parentBlock.parentFunction appendBlockWithName: [NSString stringWithFormat: @"%@ post", self.description]];
	[self.builder if: self then: thenBlock else: postBlock];
	
	[self.builder positionAtEndOfBlock: thenBlock];
	block();
	[self.builder jumpToBlock: postBlock];
	[self.builder positionAtEndOfBlock: postBlock];
}


-(ALLVMValue *)select:(ALLVMValue *)either or:(ALLVMValue *)or {
	return [self.builder condition: self then: either else: or];
}

@end
