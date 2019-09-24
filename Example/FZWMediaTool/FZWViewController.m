//
//  FZWViewController.m
//  FZWMediaTool
//
//  Created by 292017666@qq.com on 09/24/2019.
//  Copyright (c) 2019 292017666@qq.com. All rights reserved.
//

#import "FZWViewController.h"
#import "Masonry.h"
#import "FZWMediaTool.h"

@interface FZWViewController ()

@property (nonatomic,strong) UIButton *openCameraBtn;

@end

@implementation FZWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //创建开启相机按钮
    _openCameraBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_openCameraBtn setTitle:@"开启相机1" forState:UIControlStateNormal];
    [_openCameraBtn addTarget:self action:@selector(openCameraAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_openCameraBtn];
    
    [_openCameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.offset = 50;
    }];
}

- (IBAction)openCameraAction:(UIButton *)sender {
    [FZWMediaTool openCameraController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
