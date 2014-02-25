//
//  MGCellModel.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGCellModel : NSObject

- (id)initWithUniqueId:(NSString*)uniqueId
            sizeInUnit:(NSInteger)sizeInUnit
                 atRow:(NSInteger)row;


@property NSString *uniqueId;

// size in unit of cell in the collection view, unit could be understand as a percentage
// TODO: document it better
@property NSInteger sizeInUnit;

@property NSInteger row;

@property CGRect frame;

@end
