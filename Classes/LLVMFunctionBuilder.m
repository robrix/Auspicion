// LLVMFunctionBuilder.m
// Created by Rob Rix on 2010-05-30
// Copyright 2010 Monochrome Industries

#import "LLVMBuilder.h"
#import "LLVMFunction.h"
#import "LLVMFunctionBuilder.h"
#import "LLVMModule.h"
#import "LLVMValue.h"

@implementation LLVMFunctionBuilder

-(id)initWithFunction:(LLVMFunction *)_function {
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


-(LLVMBuilder *)builder {
	return function.module.builder;
}


-(void)declareArgumentNames:(NSArray *)names {
	NSMutableDictionary *tempNames = [[NSMutableDictionary alloc] init];
	NSUInteger i = 0;
	for(NSString *name in names) {
		[tempNames setObject: [NSNumber numberWithUnsignedInteger: i] forKey: name];
	}
	argumentNames = [tempNames copy];
	[tempNames release];
}

-(LLVMValue *)argumentNamed:(NSString *)name {
	return [function argumentAtIndex: [[argumentNames objectForKey: name] unsignedIntegerValue]];
}


-(LLVMPointerValue *)allocateVariableOfType:(LLVMType *)type value:(LLVMValue *)value {
	return nil;
}


-(void)return:(LLVMValue *)value {
	[self.builder return: value];
}

@end
