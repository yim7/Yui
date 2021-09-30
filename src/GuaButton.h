#import "GuaView.h"

@interface GuaButton : GuaView

@property GuaColor color;
@property GuaColor pressedColor;
@property(copy) NSString *text;
@property(copy) NSString *pressedText;

@end