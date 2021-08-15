//
//  ViewController.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/12.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "ViewController.h"
#import "CTTextDrawDemoController.h"
#import "CTImageDrawDemoController.h"
#import "CTGestureActionDemoController.h"
#import "CTTruncationDemoViewController.h"
#import "CTTextStyleDemoViewController.h"
#import "CTTextSizeCalculateDemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 基础的Text绘制
    [self addActionWithDetailText:@"基础的Text绘制" destViewControllClass:CTTextDrawDemoController.class];
    
    // Image绘制
    [self addActionWithDetailText:@"Image绘制" destViewControllClass:CTImageDrawDemoController.class];
    
    // 事件处理和添加自定义的View
    [self addActionWithDetailText:@"事件处理和添加自定义的View" destViewControllClass:CTGestureActionDemoController.class];
    
    // Truncation
    [self addActionWithDetailText:@"Truncation" destViewControllClass:CTTruncationDemoViewController.class];
    
    // 文字样式
    [self addActionWithDetailText:@"文字样式" destViewControllClass:CTTextStyleDemoViewController.class];
    
    // 计算Size
    [self addActionWithDetailText:@"手动计算Size和自动布局" destViewControllClass:CTTextSizeCalculateDemoViewController.class];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
