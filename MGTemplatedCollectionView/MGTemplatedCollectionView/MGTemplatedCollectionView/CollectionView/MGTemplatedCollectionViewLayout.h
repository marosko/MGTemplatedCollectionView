//
//  MGTemplatedCollectionViewLayout.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGTemplateModel;
@class MGTemplateRepresentation;

@interface MGTemplatedCollectionViewLayout : UICollectionViewLayout

- (void)setupWithTemplateRepresentation:(MGTemplateRepresentation*)templateRepresentation;

@property (nonatomic, readonly) MGTemplateModel* templateModel;

@end
