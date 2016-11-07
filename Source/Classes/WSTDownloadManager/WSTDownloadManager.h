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

/*!
 All notifications performed on main thread
 */
@protocol WSTDownloadManagerDelegate <NSObject>

- (void)downloadManager:(WSTDownloadManager *)manager didUpdatePage:(WSTPageModel *)page;
- (void)downloadManagerDidStart:(WSTDownloadManager *)manager afterStop:(BOOL)wasStopped;
- (void)downloadManagerDidSuspend:(WSTDownloadManager *)manager;
- (void)downloadManagerDidStop:(WSTDownloadManager *)manager;

@end

@interface WSTDownloadManager : NSObject
@property (nonatomic, readonly)     NSString    *targetUrlString;
@property (nonatomic, readonly)     NSString    *targetWord;
@property (nonatomic, readonly)     NSInteger   numberOfThreads;
@property (nonatomic, readonly)     NSInteger   maxDeepnes;
@property (nonatomic, readonly)     NSInteger   maxResults;

@property (nonatomic, readonly)     NSInteger   totalPages;
@property (nonatomic, readonly)     NSInteger   totalPagesWithTargetWord;

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
