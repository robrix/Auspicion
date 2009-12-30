// LLVMConcreteModule.h
// Created by Rob Rix on 2009-12-29
// Copyright 2009 Monochrome Industries

#import "LLVMModule.h"

@interface LLVMModule ()

@property (nonatomic, readonly) LLVMModuleRef moduleRef;

@end


@interface LLVMConcreteModule : LLVMModule {
	LLVMModuleRef moduleRef;
}

-(id)initWithName:(NSString *)_name context:(LLVMContext *)_context;

@end