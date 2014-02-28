//
//  MGTemplateParser.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGTemplateModel;
@class MGSyntax;
@class MGTemplateRepresentation;

@interface MGTemplateParser : NSObject

@property (nonatomic, strong) MGSyntax* syntax;

- (id)initWithSyntax:(MGSyntax*)aSyntax;

/*
 input text example:
  [a][b][ccc]
  [a][dd][ee]
 */
- (MGTemplateModel*)parsedTemplateModelFromTemplateRepresentation:(MGTemplateRepresentation*)input;



@end
