//
//  FZWCameraVC.h
//  FZWMediaTool
//
//  Created by mentos. on 2019/9/24.
//

#import <UIKit/UIKit.h>
#import "FZWCameraMenuBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZWCameraVC : UIViewController

@property (nonatomic,strong) FZWCameraMenuBarView *menuBarView;//菜单工具栏
@property (nonatomic,strong) FZWCameraLayerView *cameraLayerView;//采集层
@property (nonatomic,copy) void(^cameraCompleteBlock)(NSURL *fileUrl);

@end

NS_ASSUME_NONNULL_END
