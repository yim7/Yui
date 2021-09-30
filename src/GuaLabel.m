#import "GuaLabel.h"
#import "GuaApp.h"
#import "GuaWindow.h"
#import "SDL2_ttf/SDL_ttf.h"
#import <stdlib.h>

@interface
GuaLabel ()

@property GuaColor color;
@property(copy) NSString *text;
@property SDL_Texture *texture;

@end

@implementation GuaLabel
+ (instancetype)newWithFrame:(GuaRect)frame text:(NSString *)text color:(GuaColor)color {
    return [[self alloc] initWithFrame:frame text:text color:color];
}

+ (instancetype)newWithFrame:(GuaRect)frame text:(NSString *)text {
    GuaColor color = GuaMakeColor(0, 0, 255, 255);
    return [[self alloc] initWithFrame:frame text:text color:color];
}

- (instancetype)initWithFrame:(GuaRect)frame text:(NSString *)text color:(GuaColor)color {
    self = [super init];
    if (self) {
        // 子类没法直接访问父类实例的变量，只能用 getter
        self.frame = frame;
        _text = text;
        _color = color;
        [self setup];
    }

    return self;
}

- (void)setup {
    // 加载字体
    TTF_Font *font = TTF_OpenFont("../assets/wqy-microhei.ttc", 27);
    if (!font) {
        NSLog(@"TTF_OpenFont: %s\n", TTF_GetError());
        exit(-1);
    }
    const char *text = self.text.UTF8String;
    GuaRect rect = self.frame;
    TTF_SizeUTF8(font, text, &rect.w, &rect.h);
    self.frame = rect;
    // 绘制字体，surface 转 texture 是画字体的套路
    SDL_Surface *surface = TTF_RenderUTF8_Blended(font, text, self.color);
    GuaApp *app = [GuaApp sharedApp];
    SDL_Texture *texture = SDL_CreateTextureFromSurface(app.renderer, surface);
    if (!texture) {
        NSLog(@"TTF Texture Failed: %s\n", SDL_GetError());
        exit(-1);
    }
    self.texture = texture;
    SDL_FreeSurface(surface);
}

- (void)draw {
    GuaApp *app = [GuaApp sharedApp];
    GuaRect r = self.frame;
    // NSLog(@"gua label draw, %d %d %d %d", r.x, r.y, r.w, r.h);
    // renderer, texture，复制区域（NULL 表示是全部），复制到哪个地方
    SDL_RenderCopy(app.renderer, self.texture, NULL, &r);
}

- (void)dealloc {
    if (self.texture) {
        SDL_DestroyTexture(self.texture);
    }
}

@end