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

@end
