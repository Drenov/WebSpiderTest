//
//  WSTSearchResultTableViewCell.m
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import "WSTSearchResultTableViewCell.h"
#import "WSTPageModel.h"

@implementation WSTSearchResultTableViewCell

- (void)fillWithModel:(WSTPageModel *)model {
    self.urlStringLabel.text = model.pageUrl;
    self.targetWordCountLabel.text = @(model.targetWordCount).stringValue;
}

@end
