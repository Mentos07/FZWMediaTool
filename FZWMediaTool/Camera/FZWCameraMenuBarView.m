//
//  FZWCameraMenuBarView.m
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/26.
//

#import "FZWCameraMenuBarView.h"
#import "FZWMediaTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation FZWCameraMenuBarView {
    UIVisualEffectView *_effectView;
    UIButton *_backToBtn;
    UIButton *_flashLampBtn;
    UIButton *_albumBtn;
}

- (instancetype)init {
    if (self == [super init]) {
        //添加毛玻璃
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [self addSubview:_effectView];
        
        //返回按钮
        _backToBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_backToBtn setBackgroundImage:[FZWUtils imageToBundleWithFileName:@"back@3x.png"] forState:UIControlStateNormal];
        [_backToBtn addTarget:self action:@selector(buttonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backToBtn];
        
        //闪光灯按钮
        _flashLampBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_flashLampBtn setBackgroundImage:[FZWUtils imageToBundleWithFileName:@"flashLamp_close@3x.png"] forState:UIControlStateNormal];
        [_flashLampBtn addTarget:self action:@selector(buttonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_flashLampBtn];
        
        //图集按钮
        _albumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _albumBtn.hidden = YES;
        [_albumBtn setBackgroundImage:[FZWUtils imageToBundleWithFileName:@"fold@3x.png"] forState:UIControlStateNormal];
        [_albumBtn addTarget:self action:@selector(buttonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_albumBtn];
        
        CGFloat padding = kFZW_Size(15);
        CGFloat paddingBottom = kFZW_Size(10);
        CGFloat imgSize = kFZW_Size(23);
        [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.height.offset = KFZW_STATUS_AND_NAVIGATION_HEIGHT;
        }];
        
        [_backToBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = padding;
            make.bottom.offset = -paddingBottom;
            make.height.width.offset = imgSize;
        }];
        
        [_flashLampBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.offset = -paddingBottom;
            make.height.width.offset = imgSize;
        }];
        
        [_albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset = -padding;
            make.bottom.offset = -paddingBottom;
            make.height.width.offset = imgSize;
        }];
    }
    return self;
}

#pragma mark -- 按钮点击

- (IBAction)buttonItemAction:(UIButton *)sender {
    if ([sender isEqual:_backToBtn]) {//关闭
        [[FZWUtils getRootViewController] dismissViewControllerAnimated:YES completion:nil];
    }
    if ([sender isEqual:_flashLampBtn]) {//闪光灯
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //判断是否有闪光灯
        if([device hasTorch]){
            //请求访问硬件设备
            [device lockForConfiguration:nil];
            //判断手机操作状态
            [device setTorchMode:self.isTorchModeOn?AVCaptureTorchModeOff:AVCaptureTorchModeOn];
            self.isTorchModeOn = !self.isTorchModeOn;
        }
    }
    if ([sender isEqual:_albumBtn]) {//图集
        !_albumButtonActionBlck?:_albumButtonActionBlck();
    }
}

#pragma mark -- 动画

//view显示或隐藏动画
- (void)viewShowOrHideAnimation {
    //更新约束
    [_effectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = self.isShow?KFZW_STATUS_AND_NAVIGATION_HEIGHT:0;
    }];
    //执行动画
    FZWWeakObj(self);
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [selfWeak layoutIfNeeded];
    } completion:nil];
}

#pragma mark -- set

- (void)setIsTorchModeOn:(BOOL)isTorchModeOn {
    _isTorchModeOn = isTorchModeOn;
    //变更图标状态
    [_flashLampBtn setBackgroundImage:[FZWUtils imageToBundleWithFileName:[NSString stringWithFormat:@"flashLamp_%@@3x.png",isTorchModeOn?@"open":@"close"]] forState:UIControlStateNormal];
}

- (void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
    //执行动画
    [self viewShowOrHideAnimation];
}

- (void)setIsShowTorch:(BOOL)isShowTorch {
    _isShowTorch = isShowTorch;
    _flashLampBtn.hidden = !isShowTorch;
    if (!isShowTorch) _isTorchModeOn = NO;
}

- (void)setIsShowAlbum:(BOOL)isShowAlbum {
    _isShowAlbum = isShowAlbum;
    _albumBtn.hidden = !isShowAlbum;
}

@end
