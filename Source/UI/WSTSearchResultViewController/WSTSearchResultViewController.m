//
//  WSTSearchResultViewController.m
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import "WSTSearchResultViewController.h"
#import "WSTDownloadManager.h"
#import "WSTPageModel.h"
#import "UIViewController+ViewProperty.h"
#import "WSTSearchResultView.h"
#import "UITableView+GPUtils.h"
#import "WSTSearchResultTableViewCell.h"

GPUTViewControllerForViewPropertySyntesize(WSTSearchResultViewController, WSTSearchResultView, rootView);

@interface WSTSearchResultViewController ()
@property (nonatomic, strong)   WSTDownloadManager              *downloadManager;

@property (nonatomic, strong)   NSMutableArray<WSTPageModel*>   *dataSource;

@end

@implementation WSTSearchResultViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray new];
    [self setupDownloadManager];
}

#pragma mark -
#pragma markPrivate Methods

- (void)setupDownloadManager {
    NSString *targetWord = @"ukraine";
    NSString *targetUrlString = @"http://www.bbc.com";
    
    WSTDownloadManager *manager = [WSTDownloadManager managerWithTagretUrl:targetUrlString
                                                                targetWord:targetWord
                                                           numberOfThreads:8
                                                                maxDeepnes:3
                                                                maxResults:500];
    manager.delegate = self;
    self.downloadManager = manager;
    
    [manager start];
}

#pragma mark -
#pragma mark Actions Handling 

- (IBAction)onStart:(id)sender {
    [self.downloadManager start];
}

- (IBAction)onSuspend:(id)sender {
    [self.downloadManager suspend];
}

- (IBAction)onStop:(id)sender {
    [self.downloadManager stop];
}

#pragma mark -
#pragma mark WSTDownloadManagerDelegate

- (void)downloadManager:(WSTDownloadManager *)manager didUpdatePage:(WSTPageModel *)page {
    [self.dataSource addObject:page];
    [self.rootView.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSTSearchResultTableViewCell *cell = [tableView reusableCellWithClass:[WSTSearchResultTableViewCell class]];
    
    WSTPageModel *page = self.dataSource[indexPath.row];
    [cell fillWithModel:page];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

-       (CGFloat)tableView:(UITableView *)tableView
  heightForFooterInSection:(NSInteger)section
{
    // Create a invisible footer. Will remove extral separator lines at the end of cells
    return 0.01f;
}

@end
