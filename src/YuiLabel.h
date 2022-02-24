#import "YuiView.h"

@interface YuiLabel : YuiView

+ (instancetype)newWithFrame:(YuiRect)frame text:(NSString *)text color:(YuiColor)color;

+ (instancetype)newWithFrame:(YuiRect)frame text:(NSString *)text;
@end