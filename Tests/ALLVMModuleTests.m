// ALLVMModuleTests.m
// Created by Rob Rix on 2010-06-11
// Copyright 2010 Monochrome Industries

@interface ALLVMModuleTests : SenTestCase {
	ALLVMModule *module;
	ALLVMContext *context;
}
@end

@implementation ALLVMModuleTests

-(void)setUp {
	context = [ALLVMContext context];
	module = [ALLVMModule moduleWithName: @"ALLVMModuleTests" inContext: context];
}


-(void)testExternalFunctionsAreCached {
	[module externalFunctionWithName: NSStringFromSelector(_cmd) type: [ALLVMType functionType: context.voidType, nil]];
	
	ALLVMFunction *function = [module functionNamed: NSStringFromSelector(_cmd)];
	RXAssertNotNil(function);
	RXAssertEquals(function.functionType.returnType, context.voidType);
}

@end