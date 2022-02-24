#import "YuiWindow.h"
#import <Foundation/Foundation.h>

@interface YuiApp : NSObject

@property YuiWindow *window;
@property SDL_Renderer *renderer;

+ (instancetype)sharedApp;

@end
