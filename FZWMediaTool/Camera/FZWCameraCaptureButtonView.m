//
//  FZWCameraCaptureButtonView.m
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/25.
//

#import "FZWCameraCaptureButtonView.h"
#import <FZWMediaTool/FZWMediaTool.h>
#import "FZWMediaTool.h"

#define kCircleSize kFZW_Size(50)
#define kCABasicAnimationKey @"strokeEndAnimation"

@implementation FZWCameraCaptureButtonView {
    UIVisualEffectView *_effectView;
    UIView *_circleV;
    CAShapeLayer *_layer;//进度曲线层
}

- (instancetype)init {
    if (self == [super init]) {
        //毛玻璃
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.layer.cornerRadius = kFZW_Size(50);
        _effectView.clipsToBounds = YES;
        [self addSubview:_effectView];
        
        //圆心
        _circleV = [UIView new];
        _circleV.layer.cornerRadius = kCircleSize/2;
        _circleV.backgroundColor = [UIColor redColor];
        [self addSubview:_circleV];
        
        //运用贝塞尔曲线配合CAShapeLayer
        _layer = [CAShapeLayer layer];
        _layer.fillColor = [UIColor clearColor].CGColor;
        _layer.strokeColor = kThemeColor.CGColor;
        _layer.lineWidth = 5;
        [self.layer addSublayer:_layer];
        
        [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_circleV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.width.offset = kCircleSize;
        }];
        
        //添加点击
        UITapGestureRecognizer *singleClickRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleClickTap:)];
        singleClickRecognize.numberOfTapsRequired = 1;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:singleClickRecognize];
    }
    return self;
}

- (void)setIsStart:(BOOL)isStart {
    _isStart = isStart;
    //启动圆心动画
    [self starCircleAnimation];
    if (isStart) {
        //启动进度条动画
        [self starProgressAnimation];
    }else{
        //结束进度条动画
        _layer.strokeEnd = 0;
        [_layer removeAnimationForKey:kCABasicAnimationKey];
    }
}

#pragma mark -- 单击

- (IBAction)singleClickTap:(UITapGestureRecognizer *)sender {
    !_cameraCaptureButtonViewBlock?:_cameraCaptureButtonViewBlock(!self.isStart?FZWCameraCaptureButtonViewActionRecord:FZWCameraCaptureButtonViewActionStop);
}

#pragma mark -- 动画

//进度条动画
- (void)starProgressAnimation {
    //贝塞尔曲线 -- 获取一下最佳位置
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:_circleV.center radius:kCircleSize startAngle:-M_PI_2 endAngle:-M_PI_2+M_PI*2 clockwise:YES];
    _layer.path = bezierPath.CGPath;
    //动画时间
    NSInteger time = 15;
    //制作执行动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = time;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.repeatCount = MAXFLOAT;
    [_layer addAnimation:animation forKey:kCABasicAnimationKey];
}

//圆心动画
- (void)starCircleAnimation {
    FZWWeakObj(_circleV);
    CGFloat cornerRadius = _isStart?kFZW_Size(8):kCircleSize/2;
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _circleVWeak.layer.cornerRadius = cornerRadius;
    } completion:nil];
}

@end
