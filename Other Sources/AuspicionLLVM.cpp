// AuspicionLLVM.m
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#include "AuspicionLLVM.h"

#include "llvm/ExecutionEngine/ExecutionEngine.h"

void *AuspicionLLVMGetPointerToFunction(LLVMExecutionEngineRef compiler, LLVMValueRef function) {
	llvm::ExecutionEngine *cppCompiler = llvm::unwrap(compiler);
	llvm::Function *cppFunction = llvm::unwrap<llvm::Function>(function);
	return cppCompiler->getPointerToFunction(cppFunction);
}