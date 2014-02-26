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
    self.lineIndex = -1;
    [self addNewRow];
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
    _lineIndex++;
    [self.cellModels addObject:[NSMutableArray array]];
}

- (CGRect)frameForCellAtIndex:(NSInteger)anIndex
{
    if ( anIndex >= [self.cellModelsFlat count] ) {
        NSLog(@"WARNING: asking for size of cell in index that is out of bounds! returns empty rect");
        return CGRectNull;
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

@end
