//
//  MGTemplateModelDecorator.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/22/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGTemplateModel;

@interface MGTemplateModelDecorator : NSObject

- (void)calculateCellsPositionsInTemplateModel:(MGTemplateModel*)templateModel
                             forCollectionView:(UICollectionView*)collectionView;

@end
