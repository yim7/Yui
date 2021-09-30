#import "GuaGeometry.h"

BOOL
pointInRect(GuaPoint point, GuaRect rect) {
    if (point.x >= rect.x && point.x <= rect.x + rect.w) {
        if (point.y>= rect.y && point.y <= rect.y + rect.h) {
            return YES;
        }
    }
    return NO;
}