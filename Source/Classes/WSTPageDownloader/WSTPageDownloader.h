//
//  WSTPageDownloader.h
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import <Foundation/Foundation.h>

@class WSTPageModel;

@interface WSTPageDownloader : NSOperation
@property (nonatomic, readonly)           WSTPageModel  *pageModel;

+ (instancetype)downloaderWithPageModel:(WSTPageModel *)model;

- (instancetype)initWithPageModel:(WSTPageModel *)model;

@end
