// AuspicionLLVM.m
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#include "AuspicionLLVM.h"

#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "string"

void *AuspicionLLVMGetPointerToFunction(LLVMExecutionEngineRef compiler, LLVMValueRef function) {
	llvm::ExecutionEngine *cppCompiler = llvm::unwrap(compiler);
	llvm::Function *cppFunction = llvm::unwrap<llvm::Function>(function);
	return cppCompiler->getPointerToFunction(cppFunction);
}

LLVMTypeRef AuspicionLLVMGetFunctionType(LLVMValueRef function) {
	llvm::Function *cppFunction = llvm::unwrap<llvm::Function>(function);
	const llvm::FunctionType *cppType = cppFunction->getFunctionType();
	return llvm::wrap(cppType);
}

char *AuspicionLLVMPrintValue(LLVMValueRef value) {
	std::string string;
	llvm::raw_string_ostream ostream(string);
	llvm::Value *cppValue = llvm::unwrap<llvm::Value>(value);
	cppValue->print(ostream);
	const char *cString = ostream.str().c_str();
	size_t length = ostream.str().length();
	char *result = (char *)malloc(length);
	memcpy((void *)result, (const void *)cString, length);
	return result;
}

char *AuspicionLLVMPrintType(LLVMTypeRef type) {
	std::string string;
	llvm::raw_string_ostream ostream(string);
	llvm::Type *cppType = llvm::unwrap<llvm::Type>(type);
	cppType->print(ostream);
	const char *cString = ostream.str().c_str();
	size_t length = ostream.str().length();
	char *result = (char *)malloc(length);
	memcpy((void *)result, (const void *)cString, length);
	return result;
}