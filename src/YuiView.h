#import "YuiColor.h"
#import "YuiGeometry.h"
#import "SDL2/SDL.h"
#import <Foundation/Foundation.h>

@interface YuiView : NSObject

@property YuiRect frame;

+ (instancetype)newWithFrame:(YuiRect)frame;

// 这个子类必须覆盖实现
- (void)setup;

- (void)update;

- (void)draw;

- (void)mouseEvent:(SDL_Event *)event;

- (void)keyboardEvent:(SDL_Event *)event;

- (void)textInputEvent:(SDL_Event *)event;

- (void)drawRect:(YuiRect)rect;

- (void)drawRect:(YuiRect)rect color:(YuiColor)color;

@end