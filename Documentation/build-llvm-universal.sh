#!/bin/bash
# -lLLVMX86Disassembler
# -lLLVMX86AsmParser
# -lLLVMX86AsmPrinter
# -lLLVMX86CodeGen
# -lLLVMSelectionDAG
# -lLLVMAsmPrinter
# -lLLVMX86Info
# -lLLVMInterpreter
# -lLLVMipa
# -lLLVMMC
# 
# -lLLVMTransformUtils
# -lLLVMTarget
# -lLLVMCodeGen
# -lLLVMJIT
# -lLLVMScalarOpts
# -lLLVMExecutionEngine
# -lLLVMAnalysis
# -lLLVMCore
# -lLLVMSupport
# -lLLVMSystem

cd "$1"

export UNIVERSAL=true
export UNIVERSAL_ARCH="i386 x86_64 ppc ppc64"
export UNIVERSAL_SDK_PATH=/Developer/SDKs/MacOSX10.5.sdk/
# export CFLAGS="-mmacosx-version-min=10.5"
# export CXXFLAGS="-mmacosx-version-min=10.5"
# export DARWIN_VERSION=10.5
# export PATH="$(pwd):$PATH"

./configure --enable-optimized --enable-jit --enable-targets=x86,x86_64,powerpc
make libs-only