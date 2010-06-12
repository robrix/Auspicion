// ALLVMFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "ALLVMBlock+Protected.h"
#import "ALLVMBuilder.h"
#import "ALLVMContext+Protected.h"
#import "ALLVMFunction+Protected.h"
#import "ALLVMFunctionType.h"
#import "ALLVMModule+Protected.h"
#import "ALLVMType+Protected.h"
#import "ALLVMValue+Protected.h"

@implementation ALLVMFunction

+(id)functionInModule:(ALLVMModule *)module withName:(NSString *)name type:(ALLVMType *)type {
	return [ALLVMFunction valueWithValueRef: LLVMAddFunction(module.moduleRef, [name UTF8String], type.typeRef)];
}


-(LLVMLinkage)linkage {
	return LLVMGetLinkage(self.valueRef);
}

-(void)setLinkage:(LLVMLinkage)_linkage {
	LLVMSetLinkage(self.valueRef, _linkage);
}


-(ALLVMFunctionType *)functionType {
	return [ALLVMFunctionType typeWithTypeRef: AuspicionLLVMGetFunctionType(self.valueRef)];
}


-(ALLVMContext *)context {
	return self.functionType.context;
}

-(ALLVMModule *)module {
	return [ALLVMModule moduleWithModuleRef: LLVMGetGlobalParent(self.valueRef)];
}


-(ALLVMValue *)argumentAtIndex:(NSUInteger)index {
	return [ALLVMValue valueWithValueRef: LLVMGetParam(self.valueRef, index)];
}

-(ALLVMValue *)argumentNamed:(NSString *)name {
	return [self argumentAtIndex: [self.functionType indexForArgumentName: name]];
}


-(BOOL)verifyWithError:(NSError **)error {
	BOOL result = YES;
	if(LLVMVerifyFunction(self.valueRef, LLVMReturnStatusAction) == 1) {
		if(error)
			*error = [NSError errorWithDomain: @"com.monochromeindustries.Auspicion" code: -2 userInfo: nil];
		result = NO;
	}
	return result;
}


-(ALLVMBlock *)appendBlockWithName:(NSString *)name {
	return [ALLVMBlock blockWithBlockRef: LLVMAppendBasicBlockInContext(self.functionType.returnType.context.contextRef, self.valueRef, [name UTF8String])];
}


-(ALLVMBlock *)entryBlock {
	return [ALLVMBlock blockWithBlockRef: LLVMGetEntryBasicBlock(self.valueRef)];
}


// -(NSString *)description {
// 	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
// 	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
// 	free(bytes);
// 	return result;
// }


-(ALLVMValue *)call:(ALLVMValue *)argument, ... {
	va_list list;
	NSMutableArray *arguments = [NSMutableArray array];
	va_start(list, argument);
	if(self.functionType.hasVariableArity) {
		do {
			[arguments addObject: argument];
		} while(argument = va_arg(list, ALLVMValue *));
	} else {
		for(NSUInteger i = 0; i < self.functionType.arity; i++) {
			[arguments addObject: argument];
			argument = va_arg(list, ALLVMValue *);
		}
	}
	va_end(list);
	return [self.module.builder call: self arguments: arguments];
}

@end
