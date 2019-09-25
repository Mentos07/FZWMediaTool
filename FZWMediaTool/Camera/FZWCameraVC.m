//
//  FZWCameraVC.m
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/24.
//

#import "FZWCameraVC.h"
#import <FZWMediaTool/FZWMediaTool.h>
#import "FZWCameraLayerView.h"
#import "FZWCameraCaptureButtonView.h"
#import <AVKit/AVKit.h>

@interface FZWCameraVC () <FZWCaptureVideoLayerDelegate>

@property (nonatomic,strong) FZWCameraLayerView *cameraLayerView;//采集层
@property (nonatomic,strong) FZWCameraCaptureButtonView *captureButton;//采集按钮
@property (nonatomic,strong) UIButton *stopBtn;

@end

@implementation FZWCameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //相机层
    _cameraLayerView = [FZWCameraLayerView new];
    _cameraLayerView.fzw_Delegate = self;
    [self.view addSubview:_cameraLayerView];
    
    //采集按钮
    _captureButton = [FZWCameraCaptureButtonView new];
    _captureButton.layer.cornerRadius = kFZW_Size(50);
    [_cameraLayerView addSubview:_captureButton];
    
    CGFloat homebar = KFZW_HOMEBAR_HEIGHT;
    [_cameraLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_captureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.offset = -(kFZW_Size(20)+homebar);
        make.height.width.offset = kFZW_Size(100);
    }];
    
    [self bindViewModel];
}

#pragma mark -- 注册消息通知

- (void)bindViewModel {
    FZWWeakObj(self);
    //采集按钮
    [_captureButton setCameraCaptureButtonViewBlock:^(FZWCameraCaptureButtonViewAction action) {
        switch (action) {
            case FZWCameraCaptureButtonViewActionRecord://采集
                [selfWeak.cameraLayerView startRecording];
                break;
            case FZWCameraCaptureButtonViewActionStop://停止
                [selfWeak.cameraLayerView stopRecording];
            default:
                break;
        }
    }];
}

#pragma mark -- <FZWCaptureVideoLayerDelegate>

- (void)recordSucceedNoticeWithFileUrl:(NSURL *)fileUrl {
    AVPlayerViewController *vc = [[AVPlayerViewController alloc]init];
    vc.player = [[AVPlayer alloc]initWithURL:fileUrl];
    [self presentViewController:vc animated:YES completion:nil];
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
