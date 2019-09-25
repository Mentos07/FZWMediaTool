//
//  FZWCameraCaptureButtonView.h
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/25.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FZWCameraCaptureButtonViewAction) {
    FZWCameraCaptureButtonViewActionRecord               =0,//录制
    FZWCameraCaptureButtonViewActionStop,                   //停止
};

NS_ASSUME_NONNULL_BEGIN

@interface FZWCameraCaptureButtonView : UIView

@property (nonatomic,assign) BOOL isStart;//是否开始
@property (nonatomic,copy) void(^cameraCaptureButtonViewBlock)(FZWCameraCaptureButtonViewAction action);

@end

NS_ASSUME_NONNULL_END
