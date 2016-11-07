//
//  WSTMacro.h
//  WebSpiderTest
//
//  Created by Andrii Mykhailov on 11/7/16.
//
//

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
