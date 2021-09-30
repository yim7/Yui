#import "SDL2/SDL.h"

typedef SDL_Point GuaPoint;
typedef SDL_Rect GuaRect;

#define GuaMakeRect(a, b, c, d) ((GuaRect){(a), (b), (c), (d)})
#define GuaMakePoint(a, b) ((GuaPoint){(a), (b)})