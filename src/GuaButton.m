#import "GuaButton.h"
#import "GuaApp.h"
#import "GuaLabel.h"
#import "GuaWindow.h"
#import "SDL2_ttf/SDL_ttf.h"
#include <stdio.h>

@interface
GuaButton ()

@property BOOL pressed;
@property GuaColor color;
@property GuaColor pressedColor;
@property(copy) NSString *text;
@property GuaLabel *label;
@property int cooldown;

@end

@implementation GuaButton
- (void)setup {
    self.color = GuaMakeColor(0x5c, 0x73, 0x96, 255);
    self.pressedColor = GuaMakeColor(0x2f, 0x3f, 0x63, 255);
    self.text = @"确定";
    GuaRect frame = self.frame;
    frame.x += 20;
    frame.y += 10;
    GuaColor color = GuaMakeColor(255, 255, 255, 255);
    self.label = [GuaLabel newWithFrame:frame text:self.text color:color];
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
        GuaPoint p = GuaMakePoint(x, y);

        // 鼠标在按键上才允许点击
        if (pointInRect(p, self.frame)) {
            self.pressed = YES;
            self.cooldown = 7;
        }
    }
}

@end