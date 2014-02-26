//
//  MGCellModel.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "MGCellModel.h"

@implementation MGCellModel

- (id)initWithUniqueId:(NSString*)uniqueId
            sizeInUnit:(NSInteger)sizeInUnit
                 atRow:(NSInteger)row
{
    if ( self = [super init] ) {
        _uniqueId = uniqueId;
        _sizeInUnit = sizeInUnit;
        _row = row;
        _predefinedHeight = 0;
    }
    
    return self;
}

@end
