//
//  FZWMacro.h
//  Pods
//
//  Created by mentos. on 2019/9/24.
//

#ifndef FZWMacro_h
#define FZWMacro_h

#define FZWWeakObj(o) __weak typeof(o) o##Weak = o;

#pragma mark 尺寸

#define KFZW_SCREEN_SIZE [UIScreen mainScreen].bounds.size//屏幕大小
#define KFZW_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width//屏幕宽
#define KFZW_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height//屏幕高
#define KFZW_SCREEN_SCALE [UIScreen mainScreen].scale//屏幕分辨率
#define KFZW_STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height//状态栏高度
#define KFZW_HOMEBAR_HEIGHT KFZW_STATUS_BAR_HEIGHT > 20 ? 34.0f : 0.0f//homeBar高度
#define KFZW_TABBAR_HEIGHT KFZW_STATUS_BAR_HEIGHT > 20 ? 49.0f+34.0f : 49.0f
#define KFZW_NAVIGATION_BAR_HEIGHT 44
#define KFZW_STATUS_AND_NAVIGATION_HEIGHT ((KFZW_STATUS_BAR_HEIGHT) + (KFZW_NAVIGATION_BAR_HEIGHT))

#define KFZW_Min KFZW_SCREEN_HEIGHT<KFZW_SCREEN_WIDTH?KFZW_SCREEN_HEIGHT:KFZW_SCREEN_WIDTH
#define KFZW_SizeScale (KFZW_SCREEN_WIDTH <= 320 ? 1.0f : (KFZW_SCREEN_WIDTH <= 375 ? 1.1f : 1.15f))
#define kFZW_Size(value)value * KFZW_SizeScale
#define kFZW_Font(value) [UIFont systemFontOfSize:value * KFZW_SizeScale]


#pragma mark 颜色

#define kThemeColor [UIColor colorWithRed:40/255.0 green:82/255.0 blue:192/255.0 alpha:1.0] //主题颜色

#endif /* FZWMacro_h */
