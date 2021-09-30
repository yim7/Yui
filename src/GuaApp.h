#import "GuaWindow.h"
#import <Foundation/Foundation.h>

@interface GuaApp : NSObject

@property GuaWindow *window;
@property SDL_Renderer *renderer;

+ (instancetype)sharedApp;

@end
