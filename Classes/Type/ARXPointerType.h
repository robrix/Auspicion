// ARXPointerType.h
// Created by Rob Rix on 2010-06-12
// Copyright 2010 Monochrome Industries

#import "ARXType.h"

@interface ARXPointerType : ARXType

@property (nonatomic, readonly) ARXType *referencedType;

@end
