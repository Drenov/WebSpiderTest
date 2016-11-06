//
//  WSTPageModel.h
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WSTPageLoadState) {
    WSTPageLoadStateUndefined,
    WSTPageLoadStateDownloaded,
    WSTPageLoadStateFailed,
};

@interface WSTPageModel : NSObject
@property (nonatomic, copy)     NSString            *pageUrl;
@property (nonatomic, copy)     NSString            *targerWord;
@property (nonatomic, strong)   NSDate              *timeStamp;
@property (nonatomic, strong)   NSArray             *containedLinks;
@property (nonatomic, assign)   NSInteger           targetWordCount;
@property (nonatomic, assign)   NSInteger           deepnesLevel;
@property (nonatomic, assign)   WSTPageLoadState    loadState;

@end
