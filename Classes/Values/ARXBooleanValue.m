// ARXBooleanValue.m
// Created by Rob Rix on 2010-06-09
// Copyright 2010 Monochrome Industries

#import "ARXBlock.h"
#import "ARXBooleanValue.h"
#import "ARXBuilder.h"
#import "ARXFunction.h"

@implementation ARXBooleanValue

-(void)ifTrue:(void(^)())block {
	ARXBlock
		*thenBlock = [self.parentBlock.parentFunction appendBlockWithName: [NSString stringWithFormat: @"%@ ifTrue", self.description]],
		*postBlock = [self.parentBlock.parentFunction appendBlockWithName: [NSString stringWithFormat: @"%@ post", self.description]];
	[self.builder if: self then: thenBlock else: postBlock];
	
	[self.builder positionAtEndOfBlock: thenBlock];
	block();
	[self.builder jumpToBlock: postBlock];
	[self.builder positionAtEndOfBlock: postBlock];
}


-(ARXValue *)select:(ARXValue *)either or:(ARXValue *)or {
	return [self.builder condition: self then: either else: or];
}

@end
