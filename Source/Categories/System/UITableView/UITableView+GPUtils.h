
#import <UIKit/UIKit.h>

@interface UITableView (GPUtils)

- (id)reusableCellWithClass:(Class)cls;
- (id)reusableCellWithClass:(Class)cls owner:(id)owner;

- (NSIndexPath *)indexPathOfTouchEvent:(UIEvent *)event;

@end
