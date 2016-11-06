
#define GPUTViewControllerViewPropertyDefine(viewClass, propertyName) \
@property (nonatomic, strong) viewClass *propertyName;

#define GPUTViewControllerViewGetterDefine(viewClass, propertyName) \
    - (viewClass *)propertyName { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define GPUTViewControllerForViewPropertySyntesize(controllerName, viewClass, propertyName) \
    \
    @interface controllerName (_GPUTViewControllerProperty__##controllerName##__##viewClass##__##propertyName) \
    GPUTViewControllerViewPropertyDefine(viewClass, propertyName) \
    \
    @end \
    \
    @implementation controllerName (_GPUTViewControllerProperty__##controllerName##__##viewClass##__##propertyName) \
    \
    @dynamic propertyName; \
    \
    GPUTViewControllerViewGetterDefine(viewClass, propertyName) \
    \
    @end
