// LLVMConcreteType.h
// Created by Rob Rix on 2009-12-30
// Copyright 2009 Monochrome Industries

#import "LLVMType.h"

@interface LLVMType ()

@property (nonatomic, readonly) LLVMTypeRef typeRef;

@end


@interface LLVMConcreteType : LLVMType {
	LLVMTypeRef typeRef;
}

+(id)typeWithTypeRef:(LLVMTypeRef)_typeRef;
-(id)initWithTypeRef:(LLVMTypeRef)_typeRef;

@end
