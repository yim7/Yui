#import "GuaButton.h"
#import "GuaMainView.h"
#import "GuaWindow.h"
#import <Foundation/Foundation.h>

int
main(int argc, const char *argv[]) {
    GuaRect frame = GuaMakeRect(0, 0, 800, 600);
    // 创建 window 会自动初始化 GuaApp
    // GuaApp 里面是全局的东西, 主要是 sdl2 renderer
    GuaWindow *w = [GuaWindow newWithTitle:@"kui window" frame:frame];
    // window 创建后才能创建 view
    // 因为现在的 sdl2 绘图依赖 window 的全局状态
    GuaMainView *v = [GuaMainView newWithFrame:frame];
    GuaButton *button = [GuaButton newWithFrame:GuaMakeRect(100, 100, 50, 50)];
    [v addSubView:button];
    //    [v setup];
    w.rootView = v;

    [w run];

    return 0;
}