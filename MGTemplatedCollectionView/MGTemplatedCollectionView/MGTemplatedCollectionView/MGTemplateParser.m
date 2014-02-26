//
//  MGTemplateParser.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "MGTemplateParser.h"

#import "MGSyntax.h"
#import "MGCellModel.h"
#import "MGTemplateModel.h"

@implementation MGTemplateParser

- (id)initWithSyntax:(MGSyntax*)aSyntax
{
    if ( self = [self init] ) {
        _syntax = aSyntax;
    }
    
    return self;
}


- (void)firstCellModelForStringInput:(NSString*)input
                         returnBlock:(void (^)(NSString *preCellInput, NSString* cellInput, NSString* postCellInput)) returnBlock
{
    NSAssert(returnBlock != NULL, @"returnBlock is NULL, must be defined!");
    
    // escape the start and the end of the cells from special characters like: [, ], |, ...
    NSString* escapedCellStart = [NSRegularExpression escapedPatternForString:self.syntax.cellStart];
    NSString* escapedCellEnd = [NSRegularExpression escapedPatternForString:self.syntax.cellEnd];
    
    
    NSMutableString* pattern = [NSMutableString string];
    [pattern appendString:escapedCellStart]; // start of a cell
    [pattern appendString:@"(.*?)"]; // take as many character as needed (but as few as possible)
    [pattern appendString:escapedCellEnd]; // start of a cell

    NSError* error;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:&error];

    NSRange range = NSMakeRange(0, input.length);
    
    NSTextCheckingResult* result = [regex firstMatchInString:input
                                                     options:0
                                                       range:range];
    
    if ( result == nil ) {
        returnBlock(input, nil, nil);
        return;
    }
    
    NSLog(@"regex pattern: %@ search in: %@; found: %d %d", pattern, input, result.range.location, result.range.length);
    
    NSString* preCellInput = [input substringToIndex:result.range.location];
    
    // cellRange excluding cellStart and cellEnd strings
    NSRange cellRange = NSMakeRange(result.range.location + [self.syntax.cellStart length] ,
                                result.range.length - [self.syntax.cellStart length] - [self.syntax.cellEnd length]);
    

    
    NSString* cellInput = [input substringWithRange:cellRange];
    
                                        
    NSString* postCellInput = [input substringFromIndex:result.range.location + result.range.length];
    
    returnBlock(preCellInput, cellInput, postCellInput);
}


- (MGCellModel*)cellModelFromText:(NSString*)inputText atRow:(NSInteger)row
{
    // if not defined else, the cell size is taken from the "length" of a uniqueId string
    return [[MGCellModel alloc] initWithUniqueId:inputText
                                      sizeInUnit:[inputText length]
                                           atRow:row];
}

/**
 all the postRowInput must be divided by comma
 height defintion: hXXX, where XXX is a digit
 
 */
- (void)processPostCellInputText:(NSString*)postCellTextInput
                           atRow:(NSInteger)row
                forTemplateModel:(MGTemplateModel*)templateModel
{
    // check height of cells
    
    // (^|,)h\d+($|,)
    NSMutableString* pattern = [NSMutableString string];
    [pattern appendString:@"(^|,)"]; // start of an input, or devided by comma
    [pattern appendString:@"h\\d+"]; // hDIGIT e.g h10, h5, h1234
    [pattern appendString:@"($|,)"]; // start of a cell
 
    NSError* error;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:&error];

    NSTextCheckingResult* result = [regex firstMatchInString:postCellTextInput
                                                     options:0
                                                       range:NSMakeRange(0, [postCellTextInput length])];
    if ( result == nil ) {
        // TODO continue with other postCell attributes
        return;
    }
    
    // TODO: remove pre digit
    NSString* heightAttribute = [postCellTextInput substringWithRange:result.range];
    NSInteger heightInPixels = [[heightAttribute substringFromIndex:1] intValue]; // skip first 'h' character

    NSLog(@"height: %d", heightInPixels);
}


/*
 input text example:
 [a][b][ccc]
 [a][dd][ee]
 */
- (MGTemplateModel*)parsedTemplateModelFromText:(NSString*)inputText
{
 
    MGTemplateModel* templateModel = [[MGTemplateModel alloc] init];
    
    
    NSArray* rowsInputText = [inputText componentsSeparatedByString:self.syntax.newRow];

    NSInteger rowNumber = 0;
    // for each row in text (seperated by newLine sign)
    for ( NSString* inputRow in rowsInputText ) {
      
        
        __block BOOL isAnyCellAdded = NO;
        __block NSString* input = inputRow;
        __block NSString* postRowInput = nil;
        // iterate through all cells until not in the end of row
        while ( [input length] ) {
            
            [self firstCellModelForStringInput:input
                                   returnBlock:^(NSString* preCellInput, NSString* cellInput, NSString* postCellInput) {
                                       
                                       NSLog(@"preCell: %@; cell: %@; postCell: %@", preCellInput, cellInput, postCellInput);
                                       
                                       input = postCellInput;
                                       
                                       if ( [cellInput length] > 0 ) {
                                           MGCellModel* cellModel = [self cellModelFromText:cellInput atRow:rowNumber];
                                           [templateModel addCellModel:cellModel];
                                           isAnyCellAdded = YES;
                                       } else {
                                           postRowInput = preCellInput;
                                       }
                                   }];
            
        }
        
        if ( [postRowInput length] > 0 ) {
            // there is some postCell text input
            [self processPostCellInputText:postRowInput
                                     atRow:rowNumber
                          forTemplateModel:templateModel];
        }
        
        
        if ( isAnyCellAdded ) {
            rowNumber++;
            [templateModel addNewRow];
        }
        
    }
    
    return templateModel;
}




@end
