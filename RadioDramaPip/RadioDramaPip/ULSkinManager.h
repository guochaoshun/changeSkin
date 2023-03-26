//
//  ULSkinManager.h
//  RadioDramaPip
//
//  Created by 郭朝顺 on 2023/3/23.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ULSkinManagerStyle) {
    ULSkinManagerStyleDefault = 0,
    ULSkinManagerStyleLight = 1,
    ULSkinManagerStyleDark = 2,
};

/// 思路1: https://juejin.cn/post/6844903919789801479, Swift版本思路类似,使用结构如下,
/// { "弱引用某个view": {
///              "view的属性名key" : "封装的block做value",
///              "view的属性名key" : "封装的block做value"
///           }
/// }
/// 思路2:https://github.com/SlashDevelopers/SDTheme, 结构也类似, 通过类别给view添加了很多皮肤属性, 用属性记录值, 当需要换主题时, 发通知通过皮肤属性获取到新的值修改原属性的值,
/// 比如使用theme_backgroundColor 记录值, 换肤时,再次获取theme_backgroundColor的值,更新backgroundColor属性.
@interface ULSkinManager : NSObject

@property (nonatomic, assign) ULSkinManagerStyle style;

+ (instancetype)shareManager;


/// 带皮肤配置的视图设置属性
/// - Parameters:
///   - view: 需要设置的视图, 会弱应用持有该视图
///   - block: 在block中的代码会立即执行一次, 触发换肤操作会再次执行,
///            block中的view必须是弱应用weak修饰; 不使用weak会产生引用计数增加,导致视图无法释放
///   - identifier: 设置视图属性的标识,建议使用方法名或者VC类名,比如NSStringFromSelector(@selector(setBackgroundColor:)),
///                 同一对象的同一identifier, 会设置的会覆盖前一次的设置
+ (void)setView:(UIView *)view configBlock:(dispatch_block_t)block identifier:(NSString *)identifier;



/// 清除无效对象,建议时机
/// 1.可以在vc的dealloc中清理
/// 2.在收到内存警告时清理(已实现)
/// 3.在数量到达跨越一定值[50,100,150,200,...]时清理, (已实现)
- (NSInteger)clearWeakTarget;

- (void)changeSkinStyle:(ULSkinManagerStyle)style;


@end

NS_ASSUME_NONNULL_END
