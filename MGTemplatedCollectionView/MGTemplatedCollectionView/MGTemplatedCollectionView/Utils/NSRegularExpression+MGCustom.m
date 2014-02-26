//
//  NSRegularExpression+MGCustom.m
//  MGTemplatedCollectionView
//
//  Created by Maros Galik on 2/26/14.
//  Copyright (c) 2014 Maros Galik. All rights reserved.
//

#import "NSRegularExpression+MGCustom.h"

@implementation NSRegularExpression (MGCustom)

+ (NSString*)stringByReplacingPattern:(NSString*)aPattern
                             inString:(NSString*)aString
{
    
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:aPattern
                                                                            options:0
                                                                              error:NULL];

    return [regExp stringByReplacingMatchesInString:aString
                                            options:0
                                              range:NSMakeRange(0, [aString length])
                                       withTemplate:@""];
    
}

+ (NSString*)firstMatchedPattern:(NSString*)aPattern
                        inString:(NSString*)aString
{
    NSError* error;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:aPattern
                                                                           options:0
                                                                             error:&error];
    
    NSTextCheckingResult* result = [regex firstMatchInString:aString
                                                     options:0
                                                       range:NSMakeRange(0, [aString length])];
    
    if ( result == nil ) {
        return nil;
    }
    
    return [aString substringWithRange:result.range];
}


+ (NSInteger)firstMatchedIntegerInString:(NSString*)aString
{
    NSString* pattern = @"(\\d+)";
    
    return [[NSRegularExpression firstMatchedPattern:pattern inString:aString] integerValue];
}

@end
