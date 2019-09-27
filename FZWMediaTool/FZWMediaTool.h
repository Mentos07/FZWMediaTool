//
//  FZWMediaTool.h
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/24.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
#import "FZWMacro.h"
#import "FZWUtils.h"

typedef void(^CompleteBlock)(NSURL *_Nullable fileUrl);

NS_ASSUME_NONNULL_BEGIN

@interface FZWMediaTool : NSObject

/**
 打开相机
 */
+ (void)openCameraControllerWithCompleteBlock:(CompleteBlock)completeBlock;

@end

NS_ASSUME_NONNULL_END
