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
+ (void)openCameraController {
    FZWCameraVC *cameraVC = [FZWCameraVC new];
    [[FZWUtils getRootViewController] presentViewController:cameraVC animated:YES completion:nil];
}

@end
