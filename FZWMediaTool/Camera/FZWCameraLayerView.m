//
//  FZWCameraLayerView.m
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/25.
//

#import "FZWCameraLayerView.h"
#import "FZWMediaTool.h"

@interface FZWCameraLayerView ()

@property (nonatomic,strong) GPUImageStillCamera *cameraDevice;
@property (nonatomic,strong) GPUImageView *filterView;
@property (nonatomic,strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic,strong) GPUImageMovieWriter *movieWriter;

@property (nonatomic,copy) NSURL *willSaveUrl;//文件地址

@end

@implementation FZWCameraLayerView

- (instancetype)init {
    if (self == [super init]) {
        //初始化设备
        [self initGPUCaptureDevice];
    }
    return self;
}

#pragma mark -- 初始化设备

- (void)initGPUCaptureDevice {
    //初始化设备 -- 设置视频采集质量与摄像头方向
    _cameraDevice = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    _cameraDevice.outputImageOrientation = UIInterfaceOrientationPortrait;
    _cameraDevice.horizontallyMirrorFrontFacingCamera = YES;
    [_cameraDevice addAudioInputsAndOutputs];
    
    //初始化滤镜 -- 基础滤镜
    _filter = [[GPUImageFilter alloc] init];
    
    //创建视频显示画布
    _filterView = [GPUImageView new];
    _filterView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self insertSubview:_filterView atIndex:0];
    [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //响应链
    [_filter addTarget:_filterView];
    [_cameraDevice addTarget:_filter];
    
    //启动视频采集
    [_cameraDevice startCameraCapture];
}

#pragma mark -- 拍摄照片

- (void)capturePhoto {
    //采集输入流照片
    [self.cameraDevice capturePhotoAsImageProcessedUpToFilter:self.filter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        NSLog(@"");
    }];
}

#pragma mark -- 视频采集

- (void)startRecording {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isRecording = YES;
        //开始视频采集
        [self.movieWriter startRecording];
    });
}

- (void)stopRecording {
    FZWWeakObj(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        //停止视频采集
        [self.movieWriter finishRecordingWithCompletionHandler:^{//释放资源
            selfWeak.isRecording = NO;
            [selfWeak.filter removeTarget:self.movieWriter];
            selfWeak.cameraDevice.audioEncodingTarget = nil;
            selfWeak.movieWriter = nil;
        }];
    });
}

#pragma mark -- 采集结果处理

- (void)recordResultManage {
    //代理通知
    if (self.fzw_Delegate && [self.fzw_Delegate respondsToSelector:@selector(recordSucceedNoticeWithFileUrl:)]){
        [self.fzw_Delegate recordSucceedNoticeWithFileUrl:self.willSaveUrl];
    }
}

#pragma mark -- 摄像头操作

- (AVCaptureDevicePosition)rotateCamera {
    [_cameraDevice rotateCamera];
    return _cameraDevice.cameraPosition;
}

#pragma mark -- 分辨率

- (CGSize)getVideoSize {
    if (_len2wid == FZWCameraConfigLen2wid_16_9) {
        return CGSizeMake(720,1280);
    }
    return CGSizeMake(480,640);
}

#pragma mark -- 懒加载

- (GPUImageMovieWriter *)movieWriter {
    if (!_movieWriter) {
        //生成文件名
        NSString *fileName = [NSString stringWithFormat:@"video.mp4"];
        //设置写入地址
        NSString *pathToMovie = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
        //判断文件是否存在 -- 删除原有文件
        unlink([pathToMovie UTF8String]);
        _willSaveUrl = [NSURL fileURLWithPath:pathToMovie];
        //初始化写入对象
        _movieWriter = [[GPUImageMovieWriter alloc]initWithMovieURL:_willSaveUrl size:[self getVideoSize]];
        _movieWriter.encodingLiveVideo = YES;
        _movieWriter.shouldPassthroughAudio = YES;
        _movieWriter.paused = NO;
        _movieWriter.hasAudioTrack = YES;
        //添加采集器 -- 视频采集
        [_filter addTarget:_movieWriter];
        //添加采集器 -- 音频采集
        _cameraDevice.audioEncodingTarget = _movieWriter;
        //监听采集结果
        FZWWeakObj(self);
        [_movieWriter setCompletionBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [selfWeak recordResultManage];
            });
        }];
    }
    return _movieWriter;
}

@end
