// LLVMFunction.m
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "AuspicionLLVM.h"
#import "LLVMBuilder.h"
#import "LLVMConcreteBlock.h"
#import "LLVMConcreteContext.h"
#import "LLVMConcreteModule.h"
#import "LLVMFunction.h"
#import "LLVMFunction+Protected.h"
#import "LLVMType+Protected.h"
#import "LLVMValue+Protected.h"

@implementation LLVMFunction

+(id)functionInModule:(LLVMModule *)module withName:(NSString *)name type:(LLVMType *)type {
	return [LLVMFunction valueWithValueRef: LLVMAddFunction(module.moduleRef, [name UTF8String], type.typeRef)];
}


-(LLVMLinkage)linkage {
	return LLVMGetLinkage(self.valueRef);
}

-(void)setLinkage:(LLVMLinkage)_linkage {
	LLVMSetLinkage(self.valueRef, _linkage);
}


-(LLVMType *)functionType {
	return [LLVMType typeWithTypeRef: AuspicionLLVMGetFunctionType(self.valueRef)];
}


-(LLVMType *)returnType {
	return [LLVMType typeWithTypeRef: LLVMGetReturnType(self.functionType.typeRef)];
}

-(NSArray *)argumentTypes {
	NSUInteger count = LLVMCountParamTypes(self.functionType.typeRef);
	LLVMTypeRef typeRefs[count];
	LLVMGetParamTypes(self.functionType.typeRef, typeRefs);
	NSMutableArray *argumentTypes = [[NSMutableArray alloc] initWithCapacity: count];
	for(NSUInteger i = 0; i < count; i++) {
		[argumentTypes addObject: [LLVMType typeWithTypeRef: typeRefs[i]]];
	}
	return [argumentTypes autorelease];
}


-(LLVMContext *)context {
	return self.functionType.context;
}

-(LLVMModule *)module {
	return [[[LLVMConcreteModule alloc] initWithModuleRef: LLVMGetGlobalParent(self.valueRef)] autorelease];
}


-(LLVMValue *)argumentAtIndex:(NSUInteger)index {
	return [LLVMValue valueWithValueRef: LLVMGetParam(self.valueRef, index)];
}

-(NSUInteger)arity {
	return LLVMCountParamTypes(self.functionType.typeRef);
}

-(BOOL)hasVariableArity {
	return LLVMIsFunctionVarArg(self.functionType.typeRef);
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


-(LLVMBlock *)appendBlockWithName:(NSString *)name {
	return [LLVMConcreteBlock blockWithBlockRef: LLVMAppendBasicBlockInContext(self.returnType.context.contextRef, self.valueRef, [name UTF8String])];
}


-(LLVMBlock *)entryBlock {
	return [LLVMConcreteBlock blockWithBlockRef: LLVMGetEntryBasicBlock(self.valueRef)];
}


// -(NSString *)description {
// 	char *bytes = AuspicionLLVMPrintValue(self.valueRef);
// 	NSString *result = [NSString stringWithCString: bytes encoding: NSUTF8StringEncoding];
// 	free(bytes);
// 	return result;
// }


-(LLVMValue *)call:(LLVMValue *)argument, ... {
	va_list list;
	NSMutableArray *arguments = [NSMutableArray array];
	va_start(list, argument);
	if(self.hasVariableArity) {
		do {
			[arguments addObject: argument];
		} while(argument = va_arg(list, LLVMValue *));
	} else {
		for(NSUInteger i = 0; i < self.arity; i++) {
			[arguments addObject: argument];
			argument = va_arg(list, LLVMValue *);
		}
	}
	va_end(list);
	return [self.module.builder call: self arguments: arguments];
}

@end
