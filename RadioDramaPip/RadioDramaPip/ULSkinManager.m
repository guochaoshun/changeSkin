//
//  ULSkinManager.m
//  RadioDramaPip
//
//  Created by 郭朝顺 on 2023/3/23.
//

#import "ULSkinManager.h"
#import "ULSkinItemRowNode.h"

@interface ULSkinManager ()

@property (nonatomic, strong) NSMutableDictionary *data;

@end

@implementation ULSkinManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static ULSkinManager *manager = nil;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[ULSkinManager alloc] init];
        }
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = [NSMutableDictionary dictionary];
        self.style = ULSkinManagerStyleDefault;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearWeakTarget) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)changeSkinStyle:(ULSkinManagerStyle)style {
    self.style = style;
    NSDictionary *dic = [self.data copy];
    for (NSString *key in dic) {
        ULSkinItemRowNode *rowNode = [dic objectForKey:key];
        if (rowNode.target) {
            [rowNode invoke];
        } else {
            [self.data removeObjectForKey:key];
        }
    }
}

+ (void)setView:(UIView *)view configBlock:(dispatch_block_t)block identifier:(NSString *)identifier {
    if (block) {
        block();
    }

    [self addTarget:view block:block identifier:identifier];
}



- (NSInteger)clearWeakTarget {
    NSInteger clearCount = 0;
    NSDictionary *dic = [self.data copy];
    for (NSString *key in dic) {
        ULSkinItemRowNode *rowNode = [dic objectForKey:key];
        if (!rowNode.target) {
            [self.data removeObjectForKey:key];
            clearCount ++;
        }
    }
    return clearCount;
}

+ (void)addTarget:(id)target block:(dispatch_block_t)block identifier:(NSString *)identifier {

    ULSkinItemRowNode *rowNode = [[ULSkinItemRowNode alloc] init];
    rowNode.target = target;
    rowNode.actionBlock = block;
    ULSkinManager *manager = [ULSkinManager shareManager];

    NSString *key = [self buildRowNodeKey:rowNode identifier:identifier];
    [manager.data setObject:rowNode forKey:key];

    /// 需要有时机清除无效对象,
    /// 1.可以在vc的dealloc中清理,
    /// 2.在收到内存警告时清理
    /// 3.在数量到达跨越一定值[50,100,150,200,...]时清理
    if (manager.data.count % 50 == 0) {
        [manager clearWeakTarget];
    }
}

+ (NSString *)buildRowNodeKey:(ULSkinItemRowNode *)rowNode identifier:(NSString *)identifier {
    return [NSString stringWithFormat:@"%@_%p_%@",[rowNode.target class],rowNode.target,identifier];
}

@end
