//
//  MGTemplatedCollectionViewLayout.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "MGTemplatedCollectionViewLayout.h"

#import "MGTemplateModel.h"

@interface MGTemplatedCollectionViewLayout ()

@property (nonatomic, strong) NSMutableArray* layoutAttributes;

@end

@implementation MGTemplatedCollectionViewLayout

- (void)reset
{
    self.layoutAttributes = nil;
}

- (void)setTemplateModel:(MGTemplateModel *)templateModel
{
    _templateModel = templateModel;
    [self reset];
}

- (CGSize)collectionViewContentSize
{
    // TODO
    return CGSizeMake(600, 1000);
}

- (CGSize)cellSizeForItem:(NSInteger)item
{
    // TODO
    return CGSizeMake(100, 100);
}

- (void)setupLayoutAttributes
{
    self.layoutAttributes = [NSMutableArray array];
    
    for ( int i=0; i < [self.collectionView numberOfItemsInSection:0]; i++ )
    {
        // TODO: support multiple sections
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes* layoutAttributes =
        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        layoutAttributes.frame = [self.templateModel frameForCellAtIndex:i];
        
        [self.layoutAttributes addObject:layoutAttributes];
        
    }
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath
{
    return self.layoutAttributes[indexPath.item];
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect; // return an array layout attributes instances for all the views in the given rect
{
    if ( self.layoutAttributes == nil ) {
        [self setupLayoutAttributes];
    }
    return self.layoutAttributes;
}


@end
