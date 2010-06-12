// ALLVMModule+Protected.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ALLVMModule.h"

@interface ALLVMModule ()

@property (nonatomic, readonly) LLVMModuleRef moduleRef;
@property (nonatomic, readonly) LLVMModuleProviderRef moduleProviderRef;

+(ALLVMModule *)moduleWithModuleRef:(LLVMModuleRef)_moduleRef;

@end
