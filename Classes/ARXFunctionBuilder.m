// ARXFunctionBuilder.m
// Created by Rob Rix on 2010-05-30
// Copyright 2010 Monochrome Industries

#import "ARXBuilder.h"
#import "ARXFunction.h"
#import "ARXFunctionBuilder.h"
#import "ARXModule.h"
#import "ARXPointerValue.h"
#import "ARXValue.h"

@implementation ARXFunctionBuilder

-(id)initWithFunction:(ARXFunction *)_function {
	if(self = [super init]) {
		function = [_function retain];
		[self.builder positionAtEndOfFunction: function];
	}
	return self;
}

-(void)dealloc {
	[function release];
	[argumentNames release];
	[super dealloc];
}


-(ARXBuilder *)builder {
	return function.module.builder;
}


-(ARXValue *)argumentNamed:(NSString *)name {
	return [function argumentNamed: name];
}

-(ARXPointerValue *)pointerArgumentNamed:(NSString *)name {
	return (ARXPointerValue *)[self argumentNamed: name];
}

-(ARXStructureValue *)structureArgumentNamed:(NSString *)name {
	return (ARXStructureValue *)[self argumentNamed: name];
}


-(ARXBlock *)addBlockWithName:(NSString *)name {
	return [function addBlockWithName: name];
}

-(void)goto:(ARXBlock *)destination {
	[self.builder goto: destination];
}


-(ARXPointerValue *)allocateVariableOfType:(ARXType *)type {
	return [self.builder allocateLocal: @"" type: type];
}

-(ARXPointerValue *)allocateVariableOfType:(ARXType *)type value:(ARXValue *)value {
	ARXPointerValue *address = [self allocateVariableOfType: type];
	address.value = value;
	return address;
}


-(void)return:(ARXValue *)value {
	[self.builder return: value];
}

-(void)return {
	[self.builder return];
}

@end
