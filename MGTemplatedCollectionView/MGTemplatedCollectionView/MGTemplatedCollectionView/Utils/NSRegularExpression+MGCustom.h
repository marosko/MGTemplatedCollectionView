//
//  NSRegularExpression+MGCustom.h
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/26/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSRegularExpression (MGCustom)

+ (NSString*)firstMatchedPattern:(NSString*)aPattern
                        inString:(NSString*)aString;

+ (NSInteger)firstMatchedIntegerInString:(NSString*)aString;

+ (NSString*)stringByReplacingPattern:(NSString*)aPattern
                             inString:(NSString*)aString;

@end
