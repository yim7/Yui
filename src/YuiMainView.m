#import "YuiMainView.h"
#import "YuiApp.h"
#import "YuiView.h"
#import "YuiWindow.h"
#import "SDL2/SDL.h"
#import "SDL2_ttf/SDL_ttf.h"

@interface
YuiMainView ()

@property NSMutableArray *elements;

@end

@implementation YuiMainView
- (void)setup {
    self.elements = [NSMutableArray new];
}

- (void)addSubView:(YuiView *)view {
    [self.elements addObject:(id)view];
    NSLog(@"Main View add subview %@", view);
}

- (void)update {
    for (YuiView *e in self.elements) {
        [e update];
    }
}

- (void)draw {
    for (YuiView *e in self.elements) {
        [e draw];
    }
}

- (void)mouseEvent:(SDL_Event *)event {
    for (YuiView *view in self.elements) {
        [view mouseEvent:event];
    }
}

- (void)keyboardEvent:(SDL_Event *)event {
    for (YuiView *view in self.elements) {
        [view keyboardEvent:event];
    }
}

- (void)textInputEvent:(SDL_Event *)event {
    for (YuiView *view in self.elements) {
        [view textInputEvent:event];
    }
}
@end