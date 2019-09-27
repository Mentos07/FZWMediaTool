//
//  FZWCameraLayerView.h
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/25.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FZWCameraConfigLen2wid) {
    FZWCameraConfigLen2wid_16_9          = 0, //16:9
    FZWCameraConfigLen2wid_4_3,               //4:3
};

@protocol FZWCaptureVideoLayerDelegate <NSObject>
@optional

- (void)recordSucceedNoticeWithFileUrl:(NSURL *)fileUrl;

@end

@interface FZWCameraLayerView : UIView

@property (nonatomic,assign) BOOL isRecording;//是否正在录播

@property (nonatomic,assign) int videoRecordMaxTime; //视频最大时长 (单位/秒)
@property (nonatomic,assign) int videoRecordMinTime; //最短视频时长 (单位/秒) default:3秒
@property (nonatomic,assign) FZWCameraConfigLen2wid len2wid;//采集比例

@property (nonatomic,weak) id<FZWCaptureVideoLayerDelegate> fzw_Delegate;

/**
 拍摄照片
 */
- (void)capturePhoto;

/**
 开启视频录制
 */
- (void)startRecording;

/**
 停止视频录制
 */
- (void)stopRecording;

/**
 切换摄像头方向
 */
- (AVCaptureDevicePosition)rotateCamera;

@end

NS_ASSUME_NONNULL_END
