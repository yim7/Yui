#import "GuaButton.h"
#import "GuaWindow.h"

@interface
GuaButton ()

@property BOOL pressed;

@end

@implementation GuaButton
- (void)setup {
    self.color = GuaMakeColor(255, 255, 255, 255);
    self.pressedColor = GuaMakeColor(255, 0, 0, 255);
}

- (void)draw {
    if (self.pressed) {
        [self drawRect:self.frame color:self.pressedColor];
    } else {
        [self drawRect:self.frame color:self.color];
    }
}

- (void)mouseEvent:(SDL_Event *)event {
    Uint32 t = event->type;
    if (t == SDL_MOUSEBUTTONDOWN) {
        int x = event->button.x;
        int y = event->button.y;
        // BOOL mouseIn = NSPointInRect(p, self.frame);
        self.pressed = !self.pressed;
    }
}

@end