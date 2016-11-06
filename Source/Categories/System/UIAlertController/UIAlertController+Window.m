
#import "UIAlertController+Window.h"
#import "UIWindow+GPUtils.h"
#import <objc/runtime.h>

@interface UIAlertController (Private)
@property (nonatomic, strong)   UIWindow    *alertWindow;

@end

@implementation UIAlertController (Private)

@dynamic alertWindow;

#pragma mark -
#pragma mark Accessors

- (void)setAlertWindow:(UIWindow *)alertWindow {
    objc_setAssociatedObject(self, @selector(alertWindow), alertWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)alertWindow {
    return objc_getAssociatedObject(self, @selector(alertWindow));
}

@end

@implementation UIAlertController (Window)

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
}

#pragma mark -
#pragma mark Class Methods

+ (void)showAlertWithTitle:(NSString *)title {
    [self showAlertWithTitle:title andAction:nil];
}

+ (void)showAlertWithTitle:(NSString *)title andAction:(void (^)(UIAlertAction *action))handler {
    
    UIViewController *vc = [[UIApplication sharedApplication].keyWindow visibleViewController];
    if ([vc isKindOfClass:[UIAlertController class]]) {
        [vc dismissViewControllerAnimated:NO completion:nil];
    }

    
    UIAlertController   *alertController = [self alertControllerWithTitle:title
                                                                  message:nil
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:handler];
    [alertController addAction:cancelAction];
    
    [alertController show];
}

#pragma mark -
#pragma mark Public Methods

- (void)show {
    [self show:YES];
}

- (void)show:(BOOL)animated {
    self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.alertWindow.rootViewController = [UIViewController new];
    
    UIApplication *application = [UIApplication sharedApplication];
    
    self.alertWindow.windowLevel = application.windows.lastObject.windowLevel + 1;
    
    [self.alertWindow makeKeyAndVisible];
    
    [self.alertWindow.rootViewController presentViewController:self
                                                      animated:animated
                                                    completion:nil];
}

@end
