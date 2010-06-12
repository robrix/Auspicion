// ALLVMFunctionBuilder.m
// Created by Rob Rix on 2010-05-30
// Copyright 2010 Monochrome Industries

#import "ALLVMBuilder.h"
#import "ALLVMFunction.h"
#import "ALLVMFunctionBuilder.h"
#import "ALLVMModule.h"
#import "ALLVMPointerValue.h"
#import "ALLVMValue.h"

@implementation ALLVMFunctionBuilder

-(id)initWithFunction:(ALLVMFunction *)_function {
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


-(ALLVMBuilder *)builder {
	return function.module.builder;
}


-(ALLVMValue *)argumentNamed:(NSString *)name {
	return [function argumentNamed: name];
}


-(ALLVMPointerValue *)allocateVariableOfType:(ALLVMType *)type value:(ALLVMValue *)value {
	ALLVMPointerValue *address = [self.builder allocateLocal: @"" type: type];
	address.value = value;
	return address;
}


-(void)return:(ALLVMValue *)value {
	[self.builder return: value];
}

@end
