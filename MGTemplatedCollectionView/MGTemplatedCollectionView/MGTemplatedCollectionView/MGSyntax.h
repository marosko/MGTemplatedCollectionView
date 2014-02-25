//
//  MGSyntax.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGSyntax : NSObject

// start of a cell. e.g.: "["
- (NSString*)cellStart;

// end of a cell. e.g.: "]"
- (NSString*)cellEnd;

// new row (line) in a collection grid
- (NSString*)newRow;

@end
