#import "GuaWindow.h"
#import "GuaApp.h"
#import "GuaGeometry.h"
#import "SDL2/SDL.h"
#import "SDL2_ttf/SDL_ttf.h"

// 这是 extension 语法
// 用来定义一些内部属性和方法，只能在本文件中可见
@interface
GuaWindow ()

@property SDL_Window *window;
@property BOOL quit;

@end

@implementation GuaWindow
+ (instancetype)newWithTitle:(NSString *)title frame:(GuaRect)frame {
    // self 表示接收消息的对象，这是类方法，所以 self 就是类
    return [[self alloc] initWithTitle:title frame:frame];
}

- (instancetype)initWithTitle:(NSString *)title frame:(GuaRect)frame {
    self = [super init];
    if (self) {
        // @property NSString *title 生成的实际成员变量名是 _title
        // 在 init 里面我们会直接访问 _title 这样的属性
        _title = title;
        _frame = frame;
        [self initApp];
    }

    return self;
}

- (void)initApp {
    [self initSDL];

    // init GuaApp
    GuaApp *app = [GuaApp sharedApp];
    app.window = self;
    app.renderer = self.renderer;
}

- (void)initSDL {
    // todo 看一下作用？
    SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");

    // 初始化 SDL
    SDL_Init(SDL_INIT_VIDEO);
    // 初始化 SDL TTF
    if (TTF_Init() == -1) {
        printf("TTF_Init: %s\n", TTF_GetError());
        exit(2);
    }
    // 创建窗口
    // 窗口标题 窗口x 窗口y 宽 高 额外参数
    self.window = SDL_CreateWindow(self.title.UTF8String, self.frame.x, self.frame.y, self.frame.w,
                                   self.frame.h, SDL_WINDOW_RESIZABLE);

    // 创建渲染层 文档如下
    // http://wiki.libsdl.org/SDL_CreateRenderer?highlight=%28SDL_CreateRenderer%29
    _renderer =
        SDL_CreateRenderer(self.window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
}

- (void)run {
    SDL_StartTextInput();
    while (!self.quit) {
        // 更新事件，调用 view 的事件处理函数
        [self updateEvents];

        // 从 rootView 开始 update
        [self.rootView update];

        // clear
        [self clear];

        // 从 rootView 开始 draw
        [self.rootView draw];

        // 把画好的东西显示到窗口里
        SDL_RenderPresent(self.renderer);

        [self tick];
    }
    // Event loop is complete, so close the window.
    SDL_StopTextInput();
    [self destroy];
}

- (void)updateEvents {
    // window 会把事件传给 rootView
    // 1，如果是 鼠标按下、弹起、移动 事件，那么调用所有子 view 的 mouseEvent 方法
    // 2，如果是 键盘按下、弹起 事件，那么调用所有子 view 的 keyboardEvent 方法
    // 3，其他事件都暂不处理
    SDL_Event event;
    while (SDL_PollEvent(&event)) {
        if (event.type == SDL_QUIT) {
            // 窗口关闭事件，要退出程序了
            self.quit = true;
        } else if (event.type == SDL_MOUSEBUTTONDOWN || event.type == SDL_MOUSEBUTTONUP ||
                   event.type == SDL_MOUSEMOTION) {
            [self.rootView mouseEvent:&event];
        } else if (event.type == SDL_KEYDOWN || event.type == SDL_KEYUP) {
            [self.rootView keyboardEvent:&event];
        } else if (event.type == SDL_TEXTINPUT || event.type == SDL_TEXTEDITING) {
            [self.rootView textInputEvent:&event];
        } else {
            // todo 其他的事件都暂不处理
        }
    }
}

- (void)tick {
    // todo 精确帧率控制
    Uint32 timeout = SDL_GetTicks() + 1000 / 60;
    while (!SDL_TICKS_PASSED(SDL_GetTicks(), timeout)) {
    }
}

- (void)clear {
    // 设置背景颜色并清除屏幕
    SDL_SetRenderDrawColor(self.renderer, 0, 0, 0, 255);
    SDL_RenderClear(self.renderer);
}

- (void)destroy {
    SDL_DestroyRenderer(self.renderer);
    SDL_DestroyWindow(self.window);
    SDL_Quit();
}
@end