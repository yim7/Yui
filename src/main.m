#import "YuiButton.h"
#include "YuiInput.h"
#include "YuiLabel.h"
#import "YuiMainView.h"
#import "YuiWindow.h"
#import <Foundation/Foundation.h>

int
main(int argc, const char *argv[]) {
    YuiRect frame = YuiMakeRect(0, 0, 600, 500);
    // 创建 window 会自动初始化 YuiApp
    // YuiApp 里面是全局的东西, 主要是 sdl2 renderer
    YuiWindow *w = [YuiWindow newWithTitle:@"kui window" frame:frame];

    // window 创建后才能创建 view
    // 因为现在的 sdl2 绘图依赖 window 的全局状态
    YuiMainView *root = [YuiMainView newWithFrame:frame];
    YuiLabel *label = [YuiLabel newWithFrame:YuiMakeRect(250, 50, 200, 100)
                                        text:@"Chat Room"
                                       color:YuiMakeColor(255, 0, 0, 255)];
    [root addSubView:label];
    YuiButton *button = [YuiButton newWithFrame:YuiMakeRect(400, 300, 100, 50)];
    [root addSubView:button];
    YuiInput *input = [YuiInput newWithFrame:YuiMakeRect(50, 200, 300, 200)];
    [root addSubView:input];

    w.rootView = root;
    [w run];

    return 0;
}