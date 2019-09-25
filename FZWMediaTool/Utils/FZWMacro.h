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

#define KFZW_Min KFZW_SCREEN_HEIGHT<KFZW_SCREEN_WIDTH?KFZW_SCREEN_HEIGHT:KFZW_SCREEN_WIDTH
#define KFZW_SizeScale (KFZW_Min/375.0f)
#define kFZW_Size(value) value * KFZW_SizeScale
#define kFZW_Font(value) [UIFont systemFontOfSize:value * KFZW_SizeScale]

#endif /* FZWMacro_h */