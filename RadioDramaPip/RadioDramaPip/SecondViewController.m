//
//  SecondViewController.m
//  RadioDramaPip
//
//  Created by 郭朝顺 on 2023/3/25.
//

#import "SecondViewController.h"
#import "ULRadioDramaLrcView.h"
#import "ULSkinManager.h"
#import "ULSkinUIHelper.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [ULSkinUIHelper setView:self.view backgroundColorConfig:@"2"];

    ULRadioDramaLrcView *lrcView = [[ULRadioDramaLrcView alloc] init];

    lrcView.frame = CGRectMake(10, 100, 400, 100);
    [ULSkinUIHelper setView:lrcView backgroundColorConfig:@"1"];
    [self.view addSubview:lrcView];

    // 对同一个视图的,同一个属性重复设值,只会保留最后生效的一个
    [ULSkinUIHelper setView:lrcView backgroundColorConfig:@"1"];
    [ULSkinUIHelper setView:lrcView backgroundColorConfig:@"1"];
    [ULSkinUIHelper setView:lrcView backgroundColorConfig:@"1"];
    [ULSkinUIHelper setView:lrcView backgroundColorConfig:@"1"];
    [ULSkinUIHelper setView:lrcView backgroundColorConfig:@"1"];
    [ULSkinUIHelper setView:lrcView backgroundColorConfig:@"1"];


    // 设置网络图片演示
    NSDictionary *serviceData = @{@"lightImage":@"http://123.png",
                                  @"darkImage":@"http://456.png",
    };

    __weak typeof(self) weakSelf = self;
    [ULSkinUIHelper setImageView:self.imageView imageConfigBlock:^{
        NSString *urlString = nil;
        if ([ULSkinManager shareManager].style == ULSkinManagerStyleDefault) {
            urlString = serviceData[@"lightImage"];
        } else if ([ULSkinManager shareManager].style == ULSkinManagerStyleLight) {
            urlString = serviceData[@"lightImage"];
        } else if ([ULSkinManager shareManager].style == ULSkinManagerStyleDark) {
            urlString = serviceData[@"darkImage"];
        }
        NSURL *url = [NSURL URLWithString:urlString];
        weakSelf.imageView;
//        [weakSelf.imageView sd_setImageWithURL:url placeHolder:[UIImage imageNamed:@"placeHolder"]];

    }];


}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ULSkinManager *manager = [ULSkinManager shareManager];
    [manager changeSkinStyle:(manager.style+1)%3];
}

//需要监听系统暗黑模式切换的
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            NSLog(@"当前界面处于暗黑模式");
            ULSkinManager *manager = [ULSkinManager shareManager];
            [manager changeSkinStyle:ULSkinManagerStyleDark];

        } else {
            ULSkinManager *manager = [ULSkinManager shareManager];
            [manager changeSkinStyle:ULSkinManagerStyleLight];
            NSLog(@"当前模式处于Light模式");
        }
    }
}


@end
