//
//  WSTSearchResultTableViewCell.h
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import <UIKit/UIKit.h>

@interface WSTSearchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *urlStringLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetWordCountLabel;

- (void)fillWithModel:(id)model;

@end
