#import "GuaView.h"

@interface GuaLabel : GuaView

+ (instancetype)newWithFrame:(GuaRect)frame text:(NSString *)text color:(GuaColor)color;

+ (instancetype)newWithFrame:(GuaRect)frame text:(NSString *)text;
@end