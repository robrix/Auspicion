// LLVMFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "LLVMConcreteBlock.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteFunction.h"
#import "LLVMConcreteModule.h"
#import "LLVMConcreteType.h"
#import "LLVMConcreteValue.h"
#import "LLVMFunction.h"

@implementation LLVMFunction

+(id)functionInModule:(LLVMModule *)module withName:(NSString *)name type:(LLVMType *)type {
	return [LLVMConcreteFunction functionWithFunctionRef: LLVMAddFunction(module.moduleRef, [name UTF8String], type.typeRef)];
}


-(LLVMValueRef)functionRef {
	[self doesNotRecognizeSelector: _cmd];
	return NULL;
}


-(LLVMLinkage)linkage {
	return LLVMGetLinkage(self.functionRef);
}

-(void)setLinkage:(LLVMLinkage)_linkage {
	LLVMSetLinkage(self.functionRef, _linkage);
}


-(LLVMType *)functionType {
	return [LLVMConcreteType typeWithTypeRef: AuspicionLLVMGetFunctionType(self.functionRef)];
}


-(LLVMType *)returnType {
	return [LLVMConcreteType typeWithTypeRef: LLVMGetReturnType(self.functionType.typeRef)];
}

-(NSArray *)argumentTypes {
	NSUInteger count = LLVMCountParamTypes(self.functionType.typeRef);
	LLVMTypeRef typeRefs[count];
	LLVMGetParamTypes(self.functionType.typeRef, typeRefs);
	NSMutableArray *argumentTypes = [[NSMutableArray alloc] initWithCapacity: count];
	for(NSUInteger i = 0; i < count; i++) {
		[argumentTypes addObject: [LLVMConcreteType typeWithTypeRef: typeRefs[i]]];
	}
	return [argumentTypes autorelease];
}


-(LLVMContext *)context {
	return self.functionType.context;
}


-(LLVMValue *)argumentValueAtIndex:(NSUInteger)index {
	return [LLVMConcreteValue valueWithValueRef: LLVMGetParam(self.functionRef, index)];
}


-(BOOL)verifyWithError:(NSError **)error {
	BOOL result = YES;
	if(LLVMVerifyFunction(self.functionRef, LLVMReturnStatusAction) == 1) {
		if(error)
			*error = [NSError errorWithDomain: @"com.monochromeindustries.Auspicion" code: -2 userInfo: nil];
		result = NO;
	}
	return result;
}


-(LLVMBlock *)appendBlockWithName:(NSString *)name {
	return [LLVMConcreteBlock blockWithBlockRef: LLVMAppendBasicBlockInContext(self.returnType.context.contextRef, self.functionRef, [name UTF8String])];
}


-(LLVMBlock *)entryBlock {
	return [LLVMConcreteBlock blockWithBlockRef: LLVMGetEntryBasicBlock(self.functionRef)];
}

@end
