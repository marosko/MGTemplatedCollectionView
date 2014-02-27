//
//  MGTemplateInput.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/27/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "MGTemplateRepresentation.h"

@implementation MGTemplateRepresentation

- (id)initWithStringRepresentation:(NSString*)aStringRepresentation
{
    if ( self = [super init] ) {
        _stringRepresentation = aStringRepresentation;
    }
    return self;
}

@end
