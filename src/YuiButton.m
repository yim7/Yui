#import "YuiButton.h"
#import "YuiApp.h"
#import "YuiLabel.h"
#import "YuiWindow.h"
#import "SDL2_ttf/SDL_ttf.h"
#include <stdio.h>

@interface
YuiButton ()

@property BOOL pressed;
@property YuiColor color;
@property YuiColor pressedColor;
@property(copy) NSString *text;
@property YuiLabel *label;
@property int cooldown;

@end

@implementation YuiButton
- (void)setup {
    self.color = YuiMakeColor(0x5c, 0x73, 0x96, 255);
    self.pressedColor = YuiMakeColor(0x2f, 0x3f, 0x63, 255);
    self.text = @"确定";
    YuiRect frame = self.frame;
    frame.x += 20;
    frame.y += 10;
    YuiColor color = YuiMakeColor(255, 255, 255, 255);
    self.label = [YuiLabel newWithFrame:frame text:self.text color:color];
}

- (void)update {
    if (self.pressed) {
        if (self.cooldown > 0) {
            self.cooldown -= 1;
        } else {
            self.pressed = NO;
        }
    }
    // NSLog(@"button update %d %d", self.pressed, self.cooldown);
}

- (void)draw {
    if (self.pressed && self.cooldown > 0) {
        [self drawRect:self.frame color:self.pressedColor];
    } else {
        [self drawRect:self.frame color:self.color];
    }

    [self.label draw];
}

- (void)mouseEvent:(SDL_Event *)event {
    Uint32 t = event->type;
    if (t == SDL_MOUSEBUTTONDOWN) {
        int x = event->button.x;
        int y = event->button.y;
        YuiPoint p = YuiMakePoint(x, y);

        // 鼠标在按键上才允许点击
        if (pointInRect(p, self.frame)) {
            self.pressed = YES;
            self.cooldown = 7;
        }
    }
}

@end