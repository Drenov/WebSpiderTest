//
//  WSTDownloadManager.h
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import <UIKit/UIKit.h>

@class WSTDownloadManager;
@class WSTPageModel;

@protocol WSTDownloadManagerDelegate <NSObject>

- (void)downloadManager:(WSTDownloadManager *)manager didUpdatePages:(NSArray<WSTPageModel*>*)pages;

@end

@interface WSTDownloadManager : NSObject
@property (nonatomic, copy)     NSString    *targetUrlString;
@property (nonatomic, copy)     NSString    *targetWord;
@property (nonatomic, assign)   NSInteger   numberOfThreads;
@property (nonatomic, assign)   NSInteger   maxDeepnes;
@property (nonatomic, assign)   NSInteger   maxResults;

@property (nonatomic, readonly) NSArray<WSTPageModel*>      *pages;

+ (instancetype)managerWithTagretUrl:(NSString *)targetUrl
                          targetWord:(NSString *)targetUrl
                     numberOfThreads:(NSInteger)threads
                          maxDeepnes:(NSInteger)deepnes
                          maxResults:(NSInteger)maxResults;

@property (nonatomic, weak)     id          delegate;

/*!
 Starts downloading or resume if suspended
 */
- (void)start;

/*!
 Suspend downloading
 */
- (void)suspend;

/*!
 Stop and reset downloading 
 */
- (void)stop;

@end
