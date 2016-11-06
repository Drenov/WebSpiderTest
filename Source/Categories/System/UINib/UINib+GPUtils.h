
#import <UIKit/UIKit.h>

@interface UINib (GPUtils)

+ (UINib *)nibWithClass:(Class)cls;
+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)cls;
+ (id)objectWithClass:(Class)cls owner:(id)owner;

+ (id)objectWithClass:(Class)cls
               bundle:(NSBundle *)bundle
                owner:(id)owner
              options:(NSDictionary *)options;

- (id)objectWithClass:(Class)cls;
- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end
