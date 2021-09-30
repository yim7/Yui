#import "GuaColor.h"
#import "GuaGeometry.h"
#import "SDL2/SDL.h"
#import <Foundation/Foundation.h>

@interface GuaView : NSObject

@property GuaRect frame;

+ (instancetype)newWithFrame:(GuaRect)frame;

// 这个子类必须覆盖实现
- (void)setup;

- (void)update;

- (void)draw;

- (void)mouseEvent:(SDL_Event *)event;

- (void)keyboardEvent:(SDL_Event *)event;

- (void)drawRect:(GuaRect)rect;

- (void)drawRect:(GuaRect)rect color:(GuaColor)color;

@end