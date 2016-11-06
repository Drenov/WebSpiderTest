
#import <UIKit/UIKit.h>

@interface UIAlertController (Window)

+ (void)showAlertWithTitle:(NSString *)title;
+ (void)showAlertWithTitle:(NSString *)title andAction:(void (^)(UIAlertAction *action))handler;

- (void)show;
- (void)show:(BOOL)animated;

@end
