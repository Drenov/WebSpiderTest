
#import "UITableView+GPUtils.h"
#import "UINib+GPUtils.h"

@implementation UITableView (GPUtils)

#pragma mark -
#pragma mark Public

- (id)reusableCellWithClass:(Class)cls {
    return [self reusableCellWithClass:cls owner:nil];
}

- (id)reusableCellWithClass:(Class)cls owner:(id)owner {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cls)];
    if (!cell) {
        cell = [UINib objectWithClass:cls owner:owner];
    }
    
    return cell;
}

- (NSIndexPath *)indexPathOfTouchEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    NSIndexPath *path = [self indexPathForRowAtPoint:[touch locationInView:self]];
    return path;
}

@end
