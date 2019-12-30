//
//  FZWCameraVC.m
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/24.
//

#import "FZWCameraVC.h"
#import <FZWMediaTool/FZWMediaTool.h>
#import "FZWCameraCaptureButtonView.h"
#import <AVKit/AVKit.h>

@interface FZWCameraVC () <FZWCaptureVideoLayerDelegate>

@property (nonatomic,strong) FZWCameraCaptureButtonView *captureButton;//采集按钮

@end

@implementation FZWCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:1];

    //相机层
    _cameraLayerView = [FZWCameraLayerView new];
    _cameraLayerView.fzw_Delegate = self;
    [self.view addSubview:_cameraLayerView];
    
    //采集按钮
    _captureButton = [FZWCameraCaptureButtonView new];
    _captureButton.layer.cornerRadius = kFZW_Size(50);
    [self.view addSubview:_captureButton];

    //菜单工具
    _menuBarView = [FZWCameraMenuBarView new];
    [self.view addSubview:_menuBarView];
    
    CGFloat homebar = KFZW_HOMEBAR_HEIGHT;
    [_cameraLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_captureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.offset = -(kFZW_Size(20)+homebar);
        make.height.width.offset = kFZW_Size(100);
    }];

    [_menuBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset = 0;
    }];
    
    //添加点击
    UITapGestureRecognizer *singleClickRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleClickTap:)];
    singleClickRecognize.numberOfTapsRequired = 1;
    [_cameraLayerView addGestureRecognizer:singleClickRecognize];
    
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //闪光灯状态
    _menuBarView.isTorchModeOn = NO;
    //保持屏幕常亮
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    //开始采集
    [_cameraLayerView startCameraCapture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //保持屏幕常亮
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    //停止采集
    [_cameraLayerView stopCameraCapture];
}

- (void)dealloc {
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -- 注册消息通知

- (void)bindViewModel {
    FZWWeakObj(self);
    //监听是否重新进入程序
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterBackgroundNotice)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    //采集按钮
    [_captureButton setCameraCaptureButtonViewBlock:^(FZWCameraCaptureButtonViewAction action) {
        switch (action) {
            case FZWCameraCaptureButtonViewActionRecord://采集
                [selfWeak start];
                break;
            case FZWCameraCaptureButtonViewActionStop://停止
                [selfWeak stop];
            default:
                break;
        }
    }];
}

#pragma mark -- NSNotificationCenter

//重新进入程序
- (void)applicationWillEnterBackgroundNotice {
    //闪光灯状态
    _menuBarView.isTorchModeOn = NO;
    //停止录制
    [self stop];
}

#pragma mark -- manage center

//开始录制
- (void)start {
    if (!_cameraLayerView.isRecording) {//是否静默状态
        //动画启动
        self.captureButton.isStart = YES;
        //关闭导航栏
        self.menuBarView.isShow = NO;
        //采集器启动
        [self.cameraLayerView startRecording];
    }
}

//停止录制
- (void)stop {
    if (_cameraLayerView.isRecording) {//是否处于录制
        //动画停止
        self.captureButton.isStart = NO;
        //开启导航栏
        self.menuBarView.isShow = YES;
        //采集器停止
        [self.cameraLayerView stopRecording];
    }
}

#pragma mark -- 手势处理

//单击处理
- (IBAction)singleClickTap:(UITapGestureRecognizer *)sender {
    if (!_cameraLayerView.isRecording) {//是否静默状态
        //关闭交互
        sender.enabled = NO;
        //闪光灯状态
        _menuBarView.isTorchModeOn = NO;
        //切换摄像头
        AVCaptureDevicePosition position = [self.cameraLayerView rotateCamera];
        self.menuBarView.isShowTorch = position == AVCaptureDevicePositionBack;
        //延迟后开锁
        double delayInSeconds = 0.1f;
        dispatch_time_t enabledTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(enabledTime, dispatch_get_main_queue(), ^(void){
            sender.enabled = YES;
        });
    }
}

#pragma mark -- <FZWCaptureVideoLayerDelegate>

- (void)recordSucceedNoticeWithFileUrl:(NSURL *)fileUrl {
//    AVPlayerViewController *vc = [[AVPlayerViewController alloc]init];
//    vc.player = [[AVPlayer alloc]initWithURL:fileUrl];
//    [self presentViewController:vc animated:YES completion:nil];
    !_cameraCompleteBlock?:_cameraCompleteBlock(fileUrl);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
