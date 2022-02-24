#import "YuiInput.h"
#import "YuiApp.h"
#import "YuiLabel.h"
#import "YuiWindow.h"
#import "SDL2_ttf/SDL_ttf.h"
#include <stdio.h>

@interface
YuiInput ()

@property BOOL focus;
@property YuiColor textColor;
@property YuiColor backgroundColor;
@property NSString *text;
@property TTF_Font *font;
@property SDL_Texture *texture;
@property YuiRect textFrame;

@end

@implementation YuiInput
- (void)setup {
    _focus = NO;
    _textColor = YuiMakeColor(0, 0, 0, 255);
    _backgroundColor = YuiMakeColor(255, 255, 255, 255);
    _text = [NSMutableString new];
    _textFrame = YuiMakeRect(self.frame.x, self.frame.y, 0, 0);

    // 加载字体
    _font = TTF_OpenFont("../assets/wqy-microhei.ttc", 27);
    if (!_font) {
        NSLog(@"TTF_OpenFont: %s\n", TTF_GetError());
        exit(-1);
    }
}

- (void)rendererText {
    const char *text = self.text.UTF8String;
    // NSLog(@"input text: <%s>", text);
    // 绘制字体，surface 转 texture 是画字体的套路
    YuiRect frame = self.frame;
    SDL_Surface *surface = TTF_RenderUTF8_Blended_Wrapped(self.font, text, self.textColor, frame.w);
    // NSLog(@"input text surface222222: <%p>, error %s", surface, SDL_GetError());
    if (!surface) {
        self.textFrame = YuiMakeRect(frame.x, frame.y, 0, 0);
        self.texture = nil;
        return;
    }
    self.textFrame = YuiMakeRect(frame.x, frame.y, surface->w, surface->h);
    YuiApp *app = [YuiApp sharedApp];
    SDL_Texture *texture = SDL_CreateTextureFromSurface(app.renderer, surface);
    if (!texture) {
        NSLog(@"TTF Texture Failed: %s\n", SDL_GetError());
        exit(-1);
    }
    self.texture = texture;
    SDL_FreeSurface(surface);
}

- (void)draw {
    YuiApp *app = [YuiApp sharedApp];
    // draw 输入框背景
    [self drawRect:self.frame color:self.backgroundColor];
    // draw 输入的文字
    YuiRect r = self.textFrame;
    // NSLog(@"Yui label draw, %d %d %d %d", r.x, r.y, r.w, r.h);
    // renderer, texture，复制区域（NULL 表示是全部），复制到哪个地方
    SDL_RenderCopy(app.renderer, self.texture, NULL, &r);

    if (self.focus) {
        NSArray *lines = [self.text componentsSeparatedByString:@"\n"];
        NSString *line = [lines lastObject];
        int w = 0;
        TTF_SizeUTF8(self.font, line.UTF8String, &w, NULL);
        YuiRect textFrame = self.textFrame;
        YuiRect rect;
        if (w) {
            rect = YuiMakeRect(textFrame.x + w, textFrame.y + textFrame.h - 30, 5, 30);
        } else {
            rect = YuiMakeRect(textFrame.x + w, textFrame.y + textFrame.h, 5, 30);
        }
        YuiColor color = YuiMakeColor(10, 10, 10, 100);
        int time = SDL_GetTicks();
        if (time / 500 % 2) {
            [self drawRect:rect color:color];
        }
    }
}

- (void)mouseEvent:(SDL_Event *)event {
    Uint32 t = event->type;
    if (t == SDL_MOUSEBUTTONDOWN) {
        int x = event->button.x;
        int y = event->button.y;
        YuiPoint p = YuiMakePoint(x, y);
        // 鼠标在按键上才允许点击
        if (pointInRect(p, self.frame)) {
            self.focus = YES;
        } else {
            self.focus = NO;
        }
    }
}

- (void)keyboardEvent:(SDL_Event *)event {
    if (!self.focus) {
        return;
    }

    if (event->type == SDL_KEYDOWN) {
        SDL_KeyCode key = event->key.keysym.sym;
        // NSLog(@"keyboard <%d> <%d>", key, SDLK_KP_ENTER);
        if (key == SDLK_RETURN) {
            NSLog(@"enter 换行");
            self.text = [self.text stringByAppendingString:@"\n"];
        } else if (key == SDLK_BACKSPACE) {
            if ([self.text length]) {
                self.text = [self.text substringToIndex:self.text.length - 1];
            }
        }
        [self rendererText];
    }
}

- (void)textInputEvent:(SDL_Event *)event {
    if (!self.focus) {
        return;
    }
    if (event->type == SDL_TEXTINPUT) {
        NSString *input = [NSString stringWithUTF8String:event->text.text];
        NSLog(@"IME input text <%@>", input);
        self.text = [self.text stringByAppendingString:input];
        [self rendererText];
    }
}

@end