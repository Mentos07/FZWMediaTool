//
//  FZWUtils.m
//  FBSnapshotTestCase
//
//  Created by mentos. on 2019/9/24.
//

#import "FZWUtils.h"

@implementation FZWUtils

//获取根视图控制器
+ (UIViewController *)getRootViewController {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return window.rootViewController;
}

//获取本地图片资源
+ (UIImage *)imageToBundleWithFileName:(NSString *)fileName; {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:fileName ofType:nil inDirectory:@"FZWMediaTool.bundle"];
    return [UIImage imageWithContentsOfFile:path];
}

@end
