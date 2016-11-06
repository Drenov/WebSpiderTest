
#import "NSBundle+GPUtils.h"

#import <UIKit/UIKit.h>

@implementation NSBundle (TENExtensions)

#pragma mark -
#pragma mark Public

+ (NSString *)appVersion {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    return [NSString stringWithFormat:@"Application version %@ build %@", version, build];
}

- (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls owner:nil];
}


- (id)objectWithClass:(Class)cls owner:(id)owner {
    return [self objectWithClass:cls owner:owner options:nil];
}

- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options {
    NSArray *objects = [self loadNibNamed:NSStringFromClass(cls) owner:owner options:options];
    for (id object in objects) {
        if ([object isMemberOfClass:cls]) {
            return object;
        }
    }
    
    return nil;
}


@end
