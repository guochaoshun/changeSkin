//
//  ULSkinUIHelper.h
//  RadioDramaPip
//
//  Created by 郭朝顺 on 2023/3/25.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/// 这个类支持扩展很多UI设置方法,此处指保留2个
@interface ULSkinUIHelper : NSObject

/// 得有去重机制, 同一个方法重复调用,那重复的就太多了.
/// 使用block去重不理想,每次调用生成的block都是不一样的,不能作为去重的入参
+ (void)setLabel:(UILabel *)label textColorConfig:(NSString *)textColor;

+ (void)setView:(UIView *)view backgroundColorConfig:(NSString *)bgColor;

+ (void)setImageView:(UIImageView *)imageView imageConfigBlock:(dispatch_block_t)block;



+ (UIColor *)colorWithKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
