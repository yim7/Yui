#import "YuiGeometry.h"
#import "YuiMainView.h"
#import <Foundation/Foundation.h>

@interface YuiWindow : NSObject

@property(strong) YuiMainView *rootView;
@property(readonly) NSString *title;
@property(readonly) YuiRect frame;
@property(readonly) SDL_Renderer *renderer;

// + 表示类方法，可以用类名调用，类方法不能访问实例属性
// instancetype 表示方法所属的类
+ (instancetype)newWithTitle:(NSString *)title frame:(YuiRect)frame;

// - 表示实例方法，必须用实例调用
- (void)run;
@end