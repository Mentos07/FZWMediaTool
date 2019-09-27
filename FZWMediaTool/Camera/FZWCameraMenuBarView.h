//
//  FZWCameraMenuBarView.h
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZWCameraMenuBarView : UIView

@property (nonatomic,assign) BOOL isShow;//是否显示
@property (nonatomic,assign) BOOL isShowTorch;//闪光灯控制
@property (nonatomic,assign) BOOL isShowAlbum;//是否显示图集按钮
@property (nonatomic,assign) BOOL isTorchModeOn;//是否启动闪光灯
@property (nonatomic,copy) void(^albumButtonActionBlck)(void);

@end

NS_ASSUME_NONNULL_END
