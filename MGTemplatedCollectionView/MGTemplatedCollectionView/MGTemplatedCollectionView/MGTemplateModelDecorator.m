//
//  MGTemplateModelDecorator.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/22/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "MGTemplateModelDecorator.h"

#import "MGTemplateModel.h"
#import "MGCellModel.h"

@implementation MGTemplateModelDecorator

- (CGFloat)interCellsSize
{
    // space between cells, so they are not right to each other
    return 10.0;
}

- (CGFloat)cellHeight
{
    return 100.0;
}

// iterate through an array of cells and sums their sizeInUnits
- (NSInteger)sumOfUnitsInCellModelsRow:(NSArray*)cellModelRow
{
    NSInteger sum = 0;
    for ( MGCellModel* cellModel in cellModelRow ) {
        sum += cellModel.sizeInUnit;
    }
    return sum;
}

- (void)calculateCellsPositionsInTemplateModel:(MGTemplateModel*)templateModel
                             forCollectionView:(UICollectionView*)collectionView
{
    // take all sizes of unit that are defined in one row and calculate the pixel size of cells in a collectionView
    
    NSInteger rowIndex = 0;
    for ( NSArray* row in templateModel.rowsOfCellModels ) {
        
        NSInteger sumOfUnits = [self sumOfUnitsInCellModelsRow:row];
        NSInteger numberOfCells = [row count];
        
        CGFloat spaceForAllCells = collectionView.bounds.size.width - numberOfCells * [self interCellsSize];
        
        // represents a "ratio" in the screen
        CGFloat unitSize = spaceForAllCells / sumOfUnits;
        
        // setup real sizes for cells
        CGFloat posX = 0;
        for ( MGCellModel* cellModel in row ) {
            cellModel.frame = CGRectMake(posX,
                                         rowIndex * ([self cellHeight] + [self interCellsSize]),
                                         unitSize * cellModel.sizeInUnit,
                                         [self cellHeight]);
            
            // shift currentPosX by width of unitSize + interCellSize
            posX += unitSize * cellModel.sizeInUnit + [self interCellsSize];
        }
        
        rowIndex++;
    }
}

@end
