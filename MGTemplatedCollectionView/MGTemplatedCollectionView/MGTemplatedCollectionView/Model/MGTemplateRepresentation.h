//
//  MGTemplateInput.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/27/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGTemplateRepresentation : NSObject

- (id)initWithStringRepresentation:(NSString*)aStringRepresentation;

@property (nonatomic, strong) NSString* stringRepresentation;

@end
