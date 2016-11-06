//
//  NSString+WSTExtensions.m
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import "NSString+WSTExtensions.h"

@implementation NSString (WSTExtensions)

- (NSUInteger)numberOfOccurencesOfSubstring:(NSString *)substring {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:substring
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self
                                                        options:0
                                                          range:NSMakeRange(0, [self length])];
    NSLog(@"Found %lu",(unsigned long)numberOfMatches);
    
    return numberOfMatches;
}

- (NSArray *)urlLinksComponents {
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                               error:&error];
    
    NSArray *matches = [detector matchesInString:self
                                         options:0
                                           range:NSMakeRange(0, [self length])];
    
    NSMutableArray *allLinks = [NSMutableArray new];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            [allLinks addObject:url.absoluteString];
        } else {
            NSLog(@"ERROR PARSING LINKS FROM STRING");
        }
    }
    
    return allLinks;
}

- (NSString *)removeLastCharacter {
    NSInteger length = self.length;
    NSString *result = nil;
    if (length > 0) {
        result = [self substringToIndex:(length - 1)];
    }
    
    return result;
}

- (NSString *)lastCharacter {
    NSInteger length = self.length;
    NSString *result = nil;
    if (length > 0) {
        result = [self substringFromIndex:(length - 1)];
    }
    
    return result;
}

@end
