#import "YuiApp.h"

@implementation YuiApp

+ (instancetype)sharedApp {
    static YuiApp *instance = nil;
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
      instance = [self new];
    });

    return instance;
}
@end
