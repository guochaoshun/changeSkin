//
//  ULSkinUIHelper.m
//  RadioDramaPip
//
//  Created by 郭朝顺 on 2023/3/25.
//

#import "ULSkinUIHelper.h"
#import "ULSkinManager.h"

@implementation ULSkinUIHelper

+ (void)setLabel:(UILabel *)label textColorConfig:(NSString *)textColor {

    __weak typeof(label) weakLabel = label;
    dispatch_block_t block = ^{
        UIColor *color = [self colorWithKey:textColor];
        weakLabel.textColor = color;
    };

    [ULSkinManager setView:label configBlock:block identifier:NSStringFromSelector(@selector(setTextColor:))];
}

+ (void)setView:(UIView *)view backgroundColorConfig:(NSString *)bgColor {

    __weak typeof(view) weakView = view;

    dispatch_block_t block = ^{
        UIColor *color = [self colorWithKey:bgColor];
        weakView.backgroundColor = color;
    };
    [ULSkinManager setView:view configBlock:block identifier:NSStringFromSelector(@selector(setBackgroundColor:))];
}

+ (void)setImageView:(UIImageView *)imageView imageConfigBlock:(dispatch_block_t)block {
    [ULSkinManager setView:imageView configBlock:block identifier:NSStringFromSelector(@selector(setImage:))];
}


/// 读取json配置然后返回颜色, 此处简写, 只为验证效果
+ (UIColor *)colorWithKey:(NSString *)key {
    ULSkinManager *manager = [ULSkinManager shareManager];

    if (manager.style == ULSkinManagerStyleDefault) {
        if ([key isEqualToString:@"1"]) {
            return [UIColor blackColor];
        } else if ([key isEqualToString:@"2"]) {
            return [UIColor whiteColor];
        }
    } else if (manager.style == ULSkinManagerStyleLight) {
        if ([key isEqualToString:@"1"]) {
            return [UIColor grayColor];
        } else if ([key isEqualToString:@"2"]) {
            return [UIColor orangeColor];
        }
    } else if (manager.style == ULSkinManagerStyleDark) {
        if ([key isEqualToString:@"1"]) {
            return [UIColor whiteColor];
        } else if ([key isEqualToString:@"2"]) {
            return [UIColor blackColor];
        }
    } else {
        NSAssert(NO, @"未定义的类型");
    }

    return [UIColor clearColor];
}

@end
