#import "GuaButton.h"
#import "GuaApp.h"
#import "GuaLabel.h"
#import "GuaWindow.h"
#import "SDL2_ttf/SDL_ttf.h"

@interface
GuaButton ()

@property BOOL pressed;
@property GuaColor color;
@property GuaColor pressedColor;
@property(copy) NSString *text;
@property GuaLabel *label;

@end

@implementation GuaButton
- (void)setup {
    self.color = GuaMakeColor(255, 255, 255, 255);
    self.pressedColor = GuaMakeColor(0, 255, 0, 255);
    self.text = @"确定";
    GuaRect frame = self.frame;
    frame.x += 20;
    frame.y += 10;
    self.label = [GuaLabel newWithFrame:frame text:self.text];
}

- (void)draw {
    if (self.pressed) {
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
            self.pressed = !self.pressed;
        }
    }
}

@end