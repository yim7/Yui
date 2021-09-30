#import "GuaButton.h"
#include "GuaInput.h"
#include "GuaLabel.h"
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
    GuaMainView *root = [GuaMainView newWithFrame:frame];
    GuaLabel *label = [GuaLabel newWithFrame:GuaMakeRect(300, 50, 200, 100)
                                        text:@"标题栏"
                                       color:GuaMakeColor(255, 0, 0, 255)];
    [root addSubView:label];
    GuaButton *button = [GuaButton newWithFrame:GuaMakeRect(500, 400, 100, 50)];
    [root addSubView:button];
    GuaInput *input = [GuaInput newWithFrame:GuaMakeRect(50, 200, 350, 300)];
    [root addSubView:input];

    w.rootView = root;
    [w run];

    return 0;
}