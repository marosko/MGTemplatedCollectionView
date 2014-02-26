//
//  MGTemplateModel.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGCellModel;

@interface MGTemplateModel : NSObject

- (void)addCellModel:(MGCellModel*)aCellModel;
- (void)addNewRow;

- (NSInteger)numberOfCells;
- (NSArray*)rowsOfCellModels;

- (CGRect)frameForCellAtIndex:(NSInteger)anIndex;

- (void)enumarateCellsAtRow:(NSInteger)row
                 usingBlock:(void (^)(MGCellModel* cellModel, NSUInteger idx, BOOL *stop))block;

@end
