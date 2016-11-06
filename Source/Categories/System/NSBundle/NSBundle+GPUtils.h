
#import <Foundation/Foundation.h>

@interface NSBundle (GPUtils)

+ (NSString *)appVersion;

- (id)objectWithClass:(Class)cls;
- (id)objectWithClass:(Class)cls owner:(id)owner;
- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end
