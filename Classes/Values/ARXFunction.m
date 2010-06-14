// ARXFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "ARXBlock+Protected.h"
#import "ARXBuilder.h"
#import "ARXContext+Protected.h"
#import "ARXFunction+Protected.h"
#import "ARXFunctionType.h"
#import "ARXModule+Protected.h"
#import "ARXPointerValue.h"
#import "ARXType+Protected.h"
#import "ARXValue+Protected.h"

@implementation ARXFunction

+(ARXFunction *)functionInModule:(ARXModule *)module withName:(NSString *)name type:(ARXType *)type {
	return [ARXFunction valueWithValueRef: LLVMAddFunction(module.moduleRef, [name UTF8String], type.typeRef)];
}


-(LLVMLinkage)linkage {
	return LLVMGetLinkage(self.valueRef);
}

-(void)setLinkage:(LLVMLinkage)_linkage {
	LLVMSetLinkage(self.valueRef, _linkage);
}


-(ARXFunctionType *)functionType {
	return [ARXFunctionType typeWithTypeRef: AuspicionLLVMGetFunctionType(self.valueRef)];
}


-(ARXContext *)context {
	return self.functionType.context;
}

-(ARXModule *)module {
	return [ARXModule moduleWithModuleRef: LLVMGetGlobalParent(self.valueRef)];
}


-(ARXValue *)argumentAtIndex:(NSUInteger)index {
	ARXValue *value = [ARXValue valueWithValueRef: LLVMGetParam(self.valueRef, index)];
	value.isParameter = YES;
	return value;
}

-(ARXValue *)argumentNamed:(NSString *)name {
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


-(ARXBlock *)addBlockWithName:(NSString *)name {
	return [ARXBlock blockWithBlockRef: LLVMAppendBasicBlockInContext(self.functionType.returnType.context.contextRef, self.valueRef, [name UTF8String])];
}


-(ARXBlock *)entryBlock {
	return [ARXBlock blockWithBlockRef: LLVMGetEntryBasicBlock(self.valueRef)];
}


// -(NSString *)description {
// 	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
// 	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
// 	free(bytes);
// 	return result;
// }


-(ARXValue *)call:(ARXValue *)argument, ... {
	va_list list;
	NSMutableArray *arguments = [NSMutableArray array];
	va_start(list, argument);
	if(self.functionType.hasVariableArity) {
		do {
			[arguments addObject: argument];
		} while(argument = va_arg(list, ARXValue *));
	} else {
		for(NSUInteger i = 0; i < self.functionType.arity; i++) {
			[arguments addObject: argument];
			argument = va_arg(list, ARXValue *);
		}
	}
	va_end(list);
	return [self.module.builder call: self arguments: arguments];
}

@end
