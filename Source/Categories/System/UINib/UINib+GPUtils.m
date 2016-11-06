
#import "UINib+GPUtils.h"
#import "NSBundle+GPUtils.h"

@implementation UINib (TENExtensions)

#pragma mark -
#pragma mark Class Methods

+ (UINib *)nibWithClass:(Class)cls {
    return [self nibWithClass:cls bundle:nil];
}

+ (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundle {
    return [self nibWithNibName:NSStringFromClass(cls) bundle:bundle];
}

+ (id)objectWithClass:(Class)cls {
    return [self objectWithClass:cls owner:nil];
}

+ (id)objectWithClass:(Class)cls owner:(id)owner {
    return [self objectWithClass:cls bundle:nil owner:owner options:nil];
}

+ (id)objectWithClass:(Class)cls
               bundle:(NSBundle *)bundle
                owner:(id)owner
              options:(NSDictionary *)options
{
    UINib *nib = [self nibWithClass:cls bundle:bundle];
    
    return [nib objectWithClass:cls owner:owner options:options];    
}

#pragma mark -
#pragma mark Public

- (id)objectWithClass:(Class)cls {
        return [self objectWithClass:cls owner:nil options:nil];
}

- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options {
    NSArray *objects = [self instantiateWithOwner:owner options:options];
    for (id object in objects) {
        if ([object isMemberOfClass:cls]) {
            return object;
        }
    }
    
    return nil;
}

@end
