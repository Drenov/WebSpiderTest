//
//  NSArray+WSTExtensions.m
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import "NSArray+WSTExtensions.h"

@implementation NSArray (WSTExtensions)

- (NSArray *)arrayByRemovingStringDuplicates {
    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:self];
    NSArray *result = [[set array] copy];
    
    return result;
}

@end
