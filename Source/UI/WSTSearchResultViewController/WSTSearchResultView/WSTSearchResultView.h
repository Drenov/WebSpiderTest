//
//  WSTSearchResultView.h
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import <UIKit/UIKit.h>

@interface WSTSearchResultView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPagesWithTargetLabel;

@property (weak, nonatomic) IBOutlet UITextField *targetUrlTextField;
@property (weak, nonatomic) IBOutlet UITextField *targetWordTextField;

@end
