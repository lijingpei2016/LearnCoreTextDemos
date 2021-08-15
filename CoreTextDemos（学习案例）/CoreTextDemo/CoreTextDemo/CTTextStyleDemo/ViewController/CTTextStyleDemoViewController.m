//
//  CTTextStyleDemoViewController.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/17.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "CTTextStyleDemoViewController.h"
#import "YTDrawView.h"

@interface CTTextStyleDemoViewController ()

@end

@implementation CTTextStyleDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    CGRect frame = CGRectMake(0, 20, self.view.bounds.size.width, 100);
    YTDrawView *textDrawView = [[YTDrawView alloc] initWithFrame:frame];
    textDrawView.backgroundColor = [UIColor whiteColor];
    textDrawView.text = @"color:red font:16\n这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。";
    textDrawView.textColor = [UIColor redColor];
    textDrawView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textDrawView];
    
    frame = CGRectMake(0, 140, self.view.bounds.size.width, 100);
    textDrawView = [[YTDrawView alloc] initWithFrame:frame];
    textDrawView.backgroundColor = [UIColor whiteColor];
    textDrawView.text = @"color:gray font:16 align:center\n这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。";
    textDrawView.textColor = [UIColor darkGrayColor];
    textDrawView.font = [UIFont systemFontOfSize:16];
    textDrawView.textAlignment = kCTTextAlignmentCenter;
    [self.view addSubview:textDrawView];
    
    frame = CGRectMake(0, 260, self.view.bounds.size.width, 100);
    textDrawView = [[YTDrawView alloc] initWithFrame:frame];
    textDrawView.backgroundColor = [UIColor whiteColor];
    textDrawView.text = @"color:gray font:14 align:center lineSpacing:10\n这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。";
    textDrawView.textColor = [UIColor darkGrayColor];
    textDrawView.font = [UIFont systemFontOfSize:14];
    textDrawView.textAlignment = kCTTextAlignmentCenter;
    textDrawView.lineSpacing = 10;
    [self.view addSubview:textDrawView];
    
    frame = CGRectMake(0, 380, self.view.bounds.size.width, 100);
    textDrawView = [[YTDrawView alloc] initWithFrame:frame];
    textDrawView.backgroundColor = [UIColor whiteColor];
    textDrawView.text = @"这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。";
    textDrawView.textColor = [UIColor cyanColor];
    textDrawView.font = [UIFont systemFontOfSize:20];
    textDrawView.textAlignment = kCTTextAlignmentCenter;
    textDrawView.lineSpacing = 10;
    textDrawView.shadowColor = [UIColor blackColor];
    textDrawView.shadowOffset = CGSizeMake(2, 2);
    textDrawView.shadowAlpha = 1.0;
    [self.view addSubview:textDrawView];
}

@end
