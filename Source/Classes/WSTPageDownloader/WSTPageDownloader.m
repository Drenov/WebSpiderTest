//
//  WSTPageDownloader.m
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import "WSTPageDownloader.h"
#import "WSTPageModel.h"
#import "NSArray+WSTExtensions.h"
#import "NSString+WSTExtensions.h"

@interface WSTPageDownloader ()
@property (nonatomic, strong)           WSTPageModel  *pageModel;

@end

@implementation WSTPageDownloader

#pragma mark -
#pragma mark Initializations and Deallocations

+ (instancetype)downloaderWithPageModel:(WSTPageModel *)model {
    WSTPageDownloader *downloader = [[WSTPageDownloader alloc] initWithPageModel:model];
    
    return downloader;
}

- (instancetype)initWithPageModel:(WSTPageModel *)model {
    self = [super init];
    if (self) {
        self.pageModel = model;
    }
 
    return self;
}

#pragma mark -
#pragma mark Overriden

- (void)main {
    if (self.cancelled) {
        return;
    }
    
    NSError *err = nil;
    WSTPageModel *pageModel = self.pageModel;
    NSURL *url = [NSURL URLWithString:pageModel.pageUrl];
    NSString *resultPage = [NSString stringWithContentsOfURL:url
                                                    encoding:NSUTF8StringEncoding
                                                       error:&err];
    
    if (self.cancelled) {
        return;
    }
    
    if (resultPage.length && !err) {
        pageModel.timeStamp = [NSDate date];
        pageModel.targetWordCount = [resultPage numberOfOccurencesOfSubstring:pageModel.targetWord];
        pageModel.containedLinks = [self cleanedLinks:[resultPage urlLinksComponents]];
        pageModel.loadState = WSTPageLoadStateDownloaded;
    } else {
        pageModel.loadState = WSTPageLoadStateFailed;

    }
}

#pragma mark -
#pragma mark Private Methods 

- (NSArray *)cleanedLinks:(NSArray *)links {
    NSArray *result = [links arrayByRemovingStringDuplicates];
    result = [self removeExtraLinksFromLinks:result];
    result = [self fixedLinks:result];
    
    return result;
}
- (NSArray *)removeExtraLinksFromLinks:(NSArray *)links {
    NSMutableArray *allLinks = [NSMutableArray arrayWithArray:links];

    NSArray *extraStrings = @[@"jpg", @"css", @"gif", @"png", @"js", @"svg"];
    
    NSMutableArray *extraLinks = [NSMutableArray array];
    for (NSString *string in extraStrings) {
        NSPredicate *extraPredicate = [NSPredicate predicateWithFormat:@"lastPathComponent CONTAINS[c] %@" , string];
        NSArray *array = [allLinks filteredArrayUsingPredicate:extraPredicate];
        
        [extraLinks addObjectsFromArray:array];
    }
    
    [allLinks removeObjectsInArray:extraLinks];
    
    return allLinks;
}

- (NSArray *)fixedLinks:(NSArray *)links {
    NSMutableArray *result = [NSMutableArray new];
    for (NSString *link in links) {
        NSString *localLink = link;
        if ([[localLink lastCharacter] isEqualToString:@"'"]) {
            localLink = [localLink removeLastCharacter];
        }
        
        [result addObject:localLink];
    }
    
    return result;
}

@end
