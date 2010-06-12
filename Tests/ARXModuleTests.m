// ARXModuleTests.m
// Created by Rob Rix on 2010-06-11
// Copyright 2010 Monochrome Industries

@interface ARXModuleTests : SenTestCase {
	ARXModule *module;
	ARXContext *context;
}
@end

@implementation ARXModuleTests

-(void)setUp {
	context = [ARXContext context];
	module = [ARXModule moduleWithName: @"ARXModuleTests" inContext: context];
}


-(void)testExternalFunctionsAreCached {
	[module externalFunctionWithName: NSStringFromSelector(_cmd) type: [ARXType functionType: context.voidType, nil]];
	
	ARXFunction *function = [module functionNamed: NSStringFromSelector(_cmd)];
	RXAssertNotNil(function);
	RXAssertEquals(function.functionType.returnType, context.voidType);
}

@end