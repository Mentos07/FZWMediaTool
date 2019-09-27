//
//  FZWMediaTool.m
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/24.
//

#import "FZWMediaTool.h"
#import "FZWCameraVC.h"

@implementation FZWMediaTool

//打开相机
+ (void)openCameraControllerWithCompleteBlock:(CompleteBlock)completeBlock {
    FZWCameraVC *cameraVC = [FZWCameraVC new];
    cameraVC.cameraCompleteBlock = ^(NSURL * _Nonnull fileUrl) {
        !completeBlock?:completeBlock(fileUrl);
    };
    [[FZWUtils getRootViewController] presentViewController:cameraVC animated:YES completion:nil];
}

@end
