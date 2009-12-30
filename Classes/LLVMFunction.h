// LLVMFunction.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMValue.h"

enum _LLVMFunctionLinkage {
	LLVMFunctionLinkageExternal,
	LLVMFunctionLinkageAvailableExternally,
	LLVMFunctionLinkageOnceAny,
	LLVMFunctionLinkageOnceODR,
	
	LLVMFunctionLinkageWeakAny,
	LLVMFunctionLinkageWeakODR,
	
	LLVMFunctionLinkageAppending,
	LLVMFunctionLinkageInternal,
	
	LLVMFunctionLinkagePrivate,
	LLVMFunctionLinkageDLLImport,
	LLVMFunctionLinkageDLLExport,
	LLVMFunctionLinkageExternalWeak,
	LLVMFunctionLinkageGhost,
	
	LLVMFunctionLinkageCommon,
	LLVMFunctionLinkageLinkerPrivate,
};
typedef uint8_t LLVMFunctionLinkage;

@class LLVMModule, LLVMType;

@interface LLVMFunction : LLVMValue

+(id)functionInModule:(LLVMModule *)module withName:(NSString *)name type:(LLVMType *)type;

-(LLVMValue *)argumentValueAtIndex:(NSUInteger)index;

@property (nonatomic) LLVMFunctionLinkage linkage;

-(BOOL)verifyWithError:(NSError **)error;

@end