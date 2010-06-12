// AuspicionLLVM.h
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#ifndef __STDC_LIMIT_MACROS
	#define __STDC_LIMIT_MACROS
#endif
#ifndef __STDC_CONSTANT_MACROS
	#define __STDC_CONSTANT_MACROS
#endif
#import "llvm-c/Core.h"
#import "llvm-c/ExecutionEngine.h"

#ifdef __cplusplus
extern "C" {
#endif

void *AuspicionLLVMGetPointerToFunction(LLVMExecutionEngineRef compiler, LLVMValueRef function);

LLVMTypeRef AuspicionLLVMGetFunctionType(LLVMValueRef function);

LLVMContextRef AuspicionLLVMModuleGetContext(LLVMModuleRef module);

// must free the resulting string
char *AuspicionLLVMPrintValue(LLVMValueRef value);
char *AuspicionLLVMPrintType(LLVMTypeRef type);

#ifdef __cplusplus
}
#endif