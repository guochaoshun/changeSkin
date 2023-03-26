//
//  ViewController.m
//  RadioDramaPip
//
//  Created by 郭朝顺 on 2023/3/13.
//

#import "ViewController.h"
#import "ULSkinManager.h"
#import "ULSkinUIHelper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [ULSkinUIHelper setLabel:self.label textColorConfig:@"1"];

    UIColor *color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        NSLog(@"%s",__func__);
        if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return UIColor.orangeColor;
        }
        return UIColor.greenColor;
    }];
    self.view.backgroundColor = color;

    // 同样给view.backgroundColor赋值,前一个block就不会再触发
    UIColor *color2 = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        NSLog(@"%s",__func__);
        if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return UIColor.orangeColor;
        }
        return UIColor.greenColor;
    }];
    self.view.backgroundColor = color2;

    UIImage *image = [[UIImage alloc] init];
    [image.imageAsset registerImage:[UIImage imageNamed:@"1_light"] withTraitCollection:[UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight]];
    [image.imageAsset registerImage:[UIImage imageNamed:@"1_dark"] withTraitCollection:[UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark]];
    self.image2.image = image;

    UIColor *imageBG = [UIColor colorNamed:@"imageBG"];
    NSLog(@"imageBG %@",imageBG);
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

- (IBAction)clearWeakTarget:(id)sender {

    NSLog(@"clearWeakTarget -- %zd",[[ULSkinManager shareManager] clearWeakTarget]);
}



@end
