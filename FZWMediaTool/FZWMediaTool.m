//
//  FZWMediaTool.m
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/24.
//

#import "FZWMediaTool.h"
#import "FZWCameraVC.h"
#import "FZWUtils.h"

@implementation FZWMediaTool

+ (void)openCameraController {
    NSLog(@"456");
    FZWCameraVC *cameraVC = [FZWCameraVC new];
    [[FZWUtils getRootViewController] presentViewController:cameraVC animated:YES completion:nil];
}

@end
