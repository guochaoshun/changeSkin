//
//  ULSkinItemRowNode.m
//  RadioDramaPip
//
//  Created by 郭朝顺 on 2023/3/23.
//

#import "ULSkinItemRowNode.h"
#import "ULSkinManager.h"

@implementation ULSkinItemRowNode

- (void)invoke {
    if (self.actionBlock) {
        self.actionBlock();
    }
 }

- (BOOL)isEqual:(ULSkinItemRowNode *)object {
    BOOL isEqual = [super isEqual:object];
    if (isEqual) {
        return YES;
    }
    if ([self.target isEqual:object.target] && self.actionBlock == object.actionBlock) {
        return YES;
    }
    return NO;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@:%p] %@\n %@",[self class],self,self.target,self.actionBlock];
}

- (void)dealloc {
    NSLog(@"[%@] dealloc",self);
}

@end
