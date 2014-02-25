//
//  MGViewController.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "MGViewController.h"

#import "MGTemplateParser.h"
#import "MGSyntax.h"
#import "MGTemplateModel.h"
#import "MGTemplatedCollectionViewLayout.h"

#import "MGTemplateModelDecorator.h"

@interface MGViewController ()

@property (nonatomic, strong) MGTemplateModel* templateModel;

@end

@implementation MGViewController

- (void)setupWithTemplateText:(NSString*)template
{
    MGTemplateParser *parser = [[MGTemplateParser alloc] initWithSyntax:[[MGSyntax alloc] init]];

//    NSMutableString *template = [NSMutableString string];
//    [template appendString:@"[xx][bb][cc]\n"];
//    [template appendString:@"[xx][d][ee]\n"];
//    [template appendString:@"[qq][wwwww]\n"];
    
    self.templateModel = [parser parsedTemplateModelFromText:template];
    
    MGTemplateModelDecorator* modelDecorator = [[MGTemplateModelDecorator alloc] init];
    [modelDecorator calculateCellsPositionsInTemplateModel:self.templateModel
                                         forCollectionView:self.collectionView];
    
    ((MGTemplatedCollectionViewLayout*)(self.collectionView.collectionViewLayout)).templateModel = self.templateModel;
}

- (IBAction)renderTemplate:(id)sender
{
    [self setupWithTemplateText:self.templateTextView.text];
    
    [self.collectionView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"Cell"];

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberOfCells = [self.templateModel numberOfCells];
    return numberOfCells;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // "random" color
    CGFloat indexAddition = (indexPath.item * 0.05);
    if ( indexAddition > 1 ) {
        indexAddition -= ((int)indexAddition);
    }
    
    CGFloat hue = ( 0.2 + indexAddition );  //  0.0 to 1.0
    CGFloat saturation =  ( 0.1 + indexAddition );  //  0.5 to 1.0, away from white
    CGFloat brightness =  ( 0.5 + indexAddition * ( indexPath.item % 2) );  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    cell.backgroundColor = color;
    
    
    return cell;
}

@end
