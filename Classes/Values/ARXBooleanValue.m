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
		*thenBlock = [self.parentBlock.parentFunction addBlockWithName: [NSString stringWithFormat: @"%@ ifTrue", self.description]],
		*postBlock = [self.parentBlock.parentFunction addBlockWithName: [NSString stringWithFormat: @"%@ post", self.description]];
	[self.builder if: self then: thenBlock else: postBlock];
	
	[thenBlock define: ^{
		block();
		
		if(!self.builder.currentBlock.lastInstruction.isTerminator) {
			[self.builder goto: postBlock];
		}
	}];
	
	[self.builder positionAtEndOfBlock: postBlock];
}


-(ARXValue *)select:(ARXValue *)either or:(ARXValue *)or {
	return [self.builder condition: self then: either else: or];
}


-(ARXBooleanValue *)and:(ARXValue *)other {
	return [self.builder and: self, other];
}

@end
