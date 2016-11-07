//
//  WSTDownloadManager.m
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import "WSTDownloadManager.h"
#import "WSTPageDownloader.h"
#import "WSTPageModel.h"
#import "UIAlertController+Window.h"
#import "WSTMacro.h"

@interface WSTDownloadManager ()
@property (nonatomic, copy)     NSString    *targetUrlString;
@property (nonatomic, copy)     NSString    *targetWord;
@property (nonatomic, assign)   NSInteger   numberOfThreads;
@property (nonatomic, assign)   NSInteger   maxDeepnes;
@property (nonatomic, assign)   NSInteger   maxResults;

@property (nonatomic, assign)   NSInteger   totalPages;
@property (nonatomic, assign)   NSInteger   totalPagesWithTargetWord;


@property (nonatomic, strong)   NSMutableSet        *mutableCachedUrls;
@property (nonatomic, readonly) NSSet               *cachedUrls;

@property (nonatomic, assign)   BOOL                hasGotMaxResults;

@property (nonatomic, strong)   NSOperationQueue    *downloadQueue;

@end

@implementation WSTDownloadManager

@synthesize numberOfThreads = _numberOfThreads;

#pragma mark -
#pragma mark Initializations and Deallocations


+ (instancetype)managerWithTagretUrl:(NSString *)targetUrl
                          targetWord:(NSString *)targetWord
                     numberOfThreads:(NSInteger)threads
                          maxDeepnes:(NSInteger)deepnes
                          maxResults:(NSInteger)maxResults
{
    WSTDownloadManager *manager = [[WSTDownloadManager alloc] init];
    manager.targetUrlString = targetUrl;
    manager.targetWord = targetWord;
    manager.numberOfThreads = threads;
    manager.maxDeepnes = deepnes;
    manager.maxResults = maxResults;
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableCachedUrls = [NSMutableSet new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSOperationQueue *)downloadQueue {
    if (!_downloadQueue) {
        NSOperationQueue *downloadQueue = [NSOperationQueue new];
        downloadQueue.name = @"Page_download_queue";
        downloadQueue.maxConcurrentOperationCount = self.numberOfThreads;
        
        _downloadQueue = downloadQueue;
    }
    
    return _downloadQueue;
}

- (void)setNumberOfThreads:(NSInteger)numberOfThreads {
    if (numberOfThreads >= 1 && numberOfThreads <= 8 && numberOfThreads != _numberOfThreads) {
        self.downloadQueue.maxConcurrentOperationCount = numberOfThreads;
        
        _numberOfThreads = numberOfThreads;
    }
}

- (NSInteger)numberOfThreads {
    if (!_numberOfThreads) {
        _numberOfThreads = 1;
    }
    
    return _numberOfThreads;
}

- (NSSet *)cachedUrls {
    NSSet *result = [NSSet setWithSet:self.mutableCachedUrls];

    return result;
}

#pragma mark -
#pragma mark Public Methods

- (void)start {
    NSOperationQueue *downloadQueue = self.downloadQueue;
    if (downloadQueue.isSuspended) {
        downloadQueue.suspended = NO;
        dispatch_main_async_safe(^{
            [self.delegate downloadManagerDidStart:self afterStop:NO];
        });
    } else if (!downloadQueue.operations.count){
        WSTPageModel *startPage = [WSTPageModel new];
        startPage.targetWord = self.targetWord;
        startPage.pageUrl = self.targetUrlString;
        dispatch_main_async_safe(^{
            [self.delegate downloadManagerDidStart:self afterStop:YES];
        });
        
        [self processPage:startPage];
    }
}

- (void)suspend {
    self.downloadQueue.suspended = YES;
    dispatch_main_async_safe(^{
        [self.delegate downloadManagerDidSuspend:self];
    });
}

- (void)stop {
    [self.downloadQueue cancelAllOperations];
    [self.mutableCachedUrls removeAllObjects];
    self.hasGotMaxResults = NO;
    self.totalPages = 0;
    self.totalPagesWithTargetWord = 0;
    dispatch_main_async_safe(^{
        [self.delegate downloadManagerDidStop:self];
    });
}

#pragma mark -
#pragma mark Private Methods

- (void)processPages:(NSArray<WSTPageModel*>*)pages {
    for (WSTPageModel *page in pages) {
        [self processPage:page];
    }
}

- (void)processPage:(WSTPageModel *)page {
    if ([self checkMaxResultsObtained] ) {
        return;
    }
    
    [self.mutableCachedUrls addObject:page.pageUrl];

    WSTPageDownloader *downloader = [WSTPageDownloader downloaderWithPageModel:page];
    __weak typeof (downloader)weakDownloader = downloader;
    downloader.completionBlock = ^{
        if (weakDownloader.cancelled) {
            NSLog(@"Task canceled");
            
            return;
        }
        
        if (![self checkMaxResultsObtained]) {
            self.totalPages += 1;
            if (page.targetWordCount) {
                self.totalPagesWithTargetWord += 1;
            }
            
            dispatch_main_async_safe(^{
                [self.delegate downloadManager:self didUpdatePage:page];
            });
            
            NSArray *uniquePages = [self uniquePagesFromPage:page];
            [self processPages:uniquePages];
        }
    };
    
    [self.downloadQueue addOperation:downloader];
}

- (NSArray<WSTPageModel*>*)uniquePagesFromPage:(WSTPageModel *)page {
    NSMutableArray *result = [NSMutableArray new];
    NSInteger nextDeepnesLevel = page.deepnesLevel + 1;

    if (page.loadState == WSTPageLoadStateDownloaded && nextDeepnesLevel < self.maxDeepnes) {
        NSArray *uniqueLinks = [self uniqueUrlStringsFromPage:page];
        for (NSString *link in uniqueLinks) {
            WSTPageModel *newPage = [WSTPageModel new];
            newPage.targetWord = page.targetWord;
            newPage.pageUrl = link;
            newPage.deepnesLevel = nextDeepnesLevel;
            
            [result addObject:newPage];
        }
    }
    
    return result;
}

- (NSArray *)uniqueUrlStringsFromPage:(WSTPageModel *)page {
    NSSet *cachedUrls = self.cachedUrls;
    NSMutableArray *result = [NSMutableArray new];
    for (NSString *link in page.containedLinks) {
        if (![cachedUrls containsObject:link]) {
            [result addObject:link];
        }
    }
    
    return result;
}

- (BOOL)checkMaxResultsObtained {
    if (self.pages.count >= self.maxResults) {
        [self showMaxResultsCompleteMessage];
        [self.downloadQueue cancelAllOperations];
        
        return YES;
    }
    
    return NO;
}

- (void)showMaxResultsCompleteMessage {
    if (!self.hasGotMaxResults) {
        self.hasGotMaxResults = YES;
        dispatch_main_async_safe(^{
            [UIAlertController showAlertWithTitle:@"Max possible results found"];
        });
    }
}

- (void)checkAllOperationsCompleted {
    if (!self.downloadQueue.operations.count) {
        dispatch_main_async_safe(^{
            [UIAlertController showAlertWithTitle:@"Search finished"];
        });
    }
}

@end
