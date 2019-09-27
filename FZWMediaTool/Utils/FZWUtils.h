//
//  FZWUtils.h
//  FBSnapshotTestCase
//
//  Created by mentos. on 2019/9/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZWUtils : NSObject

/**
 获取根视图控制器

 @return 根视图控制器
 */
+ (UIViewController *)getRootViewController;

/**
 获取本地图片资源

 @param fileName 文件名称
 @return 图片资源
 */
+ (UIImage *)imageToBundleWithFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
