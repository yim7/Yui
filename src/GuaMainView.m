#import "GuaMainView.h"
#import "GuaApp.h"
#import "GuaView.h"
#import "GuaWindow.h"
#import "SDL2/SDL.h"
#import "SDL2_ttf/SDL_ttf.h"

@interface
GuaMainView ()

@property NSMutableArray *elements;

@end

@implementation GuaMainView
- (void)setup {
    self.elements = [NSMutableArray new];
}

- (void)addSubView:(GuaView *)view {
    [self.elements addObject:(id)view];
    NSLog(@"Main View add subview %@", view);
}

- (void)update {
    for (GuaView *e in self.elements) {
        [e draw];
    }
}

- (void)draw {
    for (GuaView *e in self.elements) {
        [e draw];
    }
}

- (void)mouseEvent:(SDL_Event *)event {
    for (GuaView *view in self.elements) {
        [view mouseEvent:event];
    }
}

- (void)keyboardEvent:(SDL_Event *)event {
    for (GuaView *view in self.elements) {
        [view keyboardEvent:event];
    }
}

@end