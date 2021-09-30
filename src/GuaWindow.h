#import "GuaGeometry.h"
#import "GuaMainView.h"
#import <Foundation/Foundation.h>

@interface GuaWindow : NSObject

@property(strong) GuaMainView *rootView;
@property(readonly) NSString *title;
@property(readonly) GuaRect frame;
@property(readonly) SDL_Renderer *renderer;

// + 表示类方法，可以用类名调用，类方法不能访问实例属性
// instancetype 表示方法所属的类
+ (instancetype)newWithTitle:(NSString *)title frame:(GuaRect)frame;

// - 表示实例方法，必须用实例调用
- (void)run;
@end