//
//  ViewController.m
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/6/16.
//
//

#import "ViewController.h"
#import "WSTDownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)onStart:(id)sender {
    NSString *targetWord = @"ukraine";
    NSString *targetUrlString = @"http://www.bbc.com";
    WSTDownloadManager *manager = [WSTDownloadManager new];
    manager.targetUrlString = targetUrlString;
    manager.targetWord = targetWord;
    manager.maxResults = 500;
    manager.maxDeepnes = 3;
    manager.numberOfThreads = 8;
    
    [manager start];
}

@end
