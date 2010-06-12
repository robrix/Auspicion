// LLVMModuleTests.m
// Created by Rob Rix on 2010-06-11
// Copyright 2010 Monochrome Industries

@interface LLVMModuleTests : SenTestCase {
	LLVMModule *module;
	LLVMContext *context;
}
@end

@implementation LLVMModuleTests

-(void)setUp {
	context = [LLVMContext context];
	module = [LLVMModule moduleWithName: @"LLVMModuleTests" inContext: context];
}


-(void)testExternalFunctionsAreCached {
	[module externalFunctionWithName: NSStringFromSelector(_cmd) type: [LLVMType functionType: context.voidType, nil]];
	
	LLVMFunction *function = [module functionNamed: NSStringFromSelector(_cmd)];
	RXAssertNotNil(function);
	RXAssertEquals(function.returnType, context.voidType);
}

@end