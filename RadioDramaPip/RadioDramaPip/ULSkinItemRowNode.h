//
//  ULSkinItemRowNode.h
//  RadioDramaPip
//
//  Created by 郭朝顺 on 2023/3/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ULSkinItemRowNode : NSObject

// 必须是weak
@property (nonatomic, weak) id target;

@property (nonatomic, copy) dispatch_block_t actionBlock;

- (void)invoke;


@end

NS_ASSUME_NONNULL_END
