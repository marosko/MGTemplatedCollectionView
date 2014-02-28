//
//  MGTemplateModel.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "MGTemplateModel.h"

#import "MGCellModel.h"


@interface MGTemplateModel ()

// cell models is a 2-dimensional array of cells
@property (nonatomic, strong) NSMutableArray* cellModels;

// the same as cellModels but in a "flat" manner
@property (nonatomic, strong) NSMutableArray* cellModelsFlat;

@property NSInteger lineIndex;

@end

@implementation MGTemplateModel

- (id)init
{
    if ( self = [super init] ) {
        [self reset];
    }
    
    return self;
}

- (void)reset
{
    self.cellModels = [NSMutableArray array];
    self.lineIndex = NSNotFound;
    self.cellModelsFlat = [NSMutableArray array];
}

- (NSInteger)numberOfCells
{
    return [self.cellModelsFlat count];
//    NSInteger sum = 0;
//    for ( NSArray* row in self.cellModels ) {
//        sum += [row count];
//    }
//    return sum;
}

- (NSArray*)rowsOfCellModels
{
    return self.cellModels;
}

- (void)addCellModel:(MGCellModel*)aCellModel
{
    if ( aCellModel != nil ) {
        // get the latest line
        NSMutableArray *line = [self.cellModels objectAtIndex:self.lineIndex];
        [line addObject:aCellModel];
        
        [self.cellModelsFlat addObject:aCellModel];
    }
}

- (void)addNewRow
{
    if ( _lineIndex == NSNotFound ) {
        _lineIndex = 0;
    } else {
        _lineIndex++;
    }
    [self.cellModels addObject:[NSMutableArray array]];
}


// when a cell out of template cell's index is requested, then the last "row template" is repeated infinitely
- (CGRect)frameForCellOutOfBoundsAtIndex:(NSInteger)atIndex
{
    NSArray* lastRow = [self.cellModels lastObject];
    
    NSInteger numberOfRowsAtLastCell = [lastRow count];
    
    CGFloat sizeOfLastRow = 0;
    CGFloat lastRowMaxY = 0;
    for ( MGCellModel* aCellModel in lastRow ) {
        if ( CGRectGetMaxY(aCellModel.frame) > lastRowMaxY ) {
            lastRowMaxY = CGRectGetMaxY(aCellModel.frame);
        }
        
        if ( CGRectGetHeight(aCellModel.frame) > sizeOfLastRow ) {
            sizeOfLastRow = CGRectGetHeight(aCellModel.frame);
        }
    }
    
    // how many rows is index out of bounds?
    NSInteger outOfBoundsRows = (atIndex - [self numberOfCells]) / numberOfRowsAtLastCell;
    
    CGFloat posY = lastRowMaxY + [self interCellsSize] + (outOfBoundsRows-1) * (sizeOfLastRow + [self interCellsSize]);
    
    // general idea - take the correspondenting cell in the last row and change it's posY
    
    NSInteger virtualIndexAtLastRow = (atIndex - [self numberOfCells]);
    if ( virtualIndexAtLastRow >= numberOfRowsAtLastCell ) { // can not modulo by 0
        virtualIndexAtLastRow %= outOfBoundsRows*numberOfRowsAtLastCell;
    }
    
    MGCellModel* virtualLastRowCellModel = [lastRow objectAtIndex:virtualIndexAtLastRow];
    
    CGRect frame = virtualLastRowCellModel.frame;
    frame.origin.y = posY;
    
    return frame;
}

- (CGRect)frameForCellAtIndex:(NSInteger)anIndex
{
    if ( anIndex >= [self.cellModelsFlat count] ) {
        // if a cell was not specified in the template, use the last row as a layout to be used
        
        return [self frameForCellOutOfBoundsAtIndex:anIndex];
        
//        NSLog(@"WARNING: asking for size of cell in index that is out of bounds! returns empty rect");
//        return CGRectNull;
    }
    
    
    MGCellModel* cellModel = [self.cellModelsFlat objectAtIndex:anIndex];
    
    return cellModel.frame;
    
   // return CGRectMake(100*anIndex + 10+anIndex, 10+100*cellModel.row, 100, 100);
}

- (void)enumarateCellsAtRow:(NSInteger)row
                 usingBlock:(void (^)(MGCellModel *, NSUInteger, BOOL *))block
{
    [[self.cellModels objectAtIndex:row] enumerateObjectsUsingBlock:block];
}

#pragma mark - MGTEmplateModelDecorator delagate

- (CGFloat)interCellsSize
{
    return 10.0;
}

@end
