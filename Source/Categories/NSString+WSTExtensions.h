//
//  NSString+WSTExtensions.h
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import <Foundation/Foundation.h>

@interface NSString (WSTExtensions)

- (NSUInteger)numberOfOccurencesOfSubstring:(NSString *)substring;
- (NSArray *)urlLinksComponents;

- (NSString *)removeLastCharacter;
- (NSString *)lastCharacter;

@end
