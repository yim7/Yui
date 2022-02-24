#import "Foundation/Foundation.h"
#import "SDL2/SDL.h"

typedef SDL_Point YuiPoint;
typedef SDL_Rect YuiRect;

#define YuiMakeRect(a, b, c, d) ((YuiRect){(a), (b), (c), (d)})
#define YuiMakePoint(a, b) ((YuiPoint){(a), (b)})

BOOL
pointInRect(YuiPoint point, YuiRect rect);