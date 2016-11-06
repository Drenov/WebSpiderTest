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
    
    WSTDownloadManager *manager = [WSTDownloadManager managerWithTagretUrl:targetUrlString
                                                                targetWord:targetWord
                                                           numberOfThreads:8
                                                                maxDeepnes:3
                                                                maxResults:500];
    
    [manager start];
}

@end
