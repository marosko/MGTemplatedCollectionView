//
//  MGSyntax.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "MGSyntax.h"

@implementation MGSyntax

// start of a cell. e.g.: "["
- (NSString*)cellStart
{
    return @"[";
}

// end of a cell. e.g.: "]"
- (NSString*)cellEnd
{
    return @"]";    
}

// new row (line) in a collection grid
- (NSString*)newRow
{
    return @"\n";
}

@end
