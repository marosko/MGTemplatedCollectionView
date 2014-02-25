//
//  MGViewController.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/20/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGViewController : UIViewController

@property (nonatomic, strong) IBOutlet UICollectionView* collectionView;

@property (nonatomic, strong) IBOutlet UITextView *templateTextView;

- (IBAction)renderTemplate:(id)sender;

@end
