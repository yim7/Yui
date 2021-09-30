#import "GuaApp.h"

@implementation GuaApp

+ (instancetype)sharedApp {
    static GuaApp *instance = nil;
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
      instance = [self new];
    });

    return instance;
}
@end
