#import "YuiView.h"
#import "YuiApp.h"
#import "YuiGeometry.h"
#import "YuiWindow.h"

@interface
YuiView ()

@end

@implementation YuiView
+ (instancetype)newWithFrame:(YuiRect)frame {
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(YuiRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
        [self setup];
    }

    return self;
}

- (void)setup {
    // 强制子类实现 setup
    // 否则父类中的这个 doesNotRecognizeSelector 会在运行时报错
    // _cmd 是每个方法都有的变量, 代表了当前被调用的这个方法
    [self doesNotRecognizeSelector:_cmd];

    // 最好的办法当然是编译时报错, 运行时还是太晚了点
    // 但是 objc 提供的 [强制子类必须实现某个方法否则编译时报错] 的机制略微重量级
    // 所以这里我们用这种方法来简单实现这个功能
}

- (void)update {
    // 子类实现自己的 update 逻辑
}

- (void)draw {
    // 子类实现自己的 draw 逻辑
}

- (void)mouseEvent:(SDL_Event *)event {
}

- (void)keyboardEvent:(SDL_Event *)event {
}

- (void)textInputEvent:(SDL_Event *)event {
    
}

- (void)drawRect:(YuiRect)rect {
    YuiApp *app = [YuiApp sharedApp];
    SDL_RenderFillRect(app.renderer, &rect);
}

- (void)drawRect:(YuiRect)rect color:(YuiColor)color {
    YuiApp *app = [YuiApp sharedApp];
    SDL_SetRenderDrawColor(app.renderer, color.r, color.g, color.b, color.a);
    SDL_RenderFillRect(app.renderer, &rect);
}

@end