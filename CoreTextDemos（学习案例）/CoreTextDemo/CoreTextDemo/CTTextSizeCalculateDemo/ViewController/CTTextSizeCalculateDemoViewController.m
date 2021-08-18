//
//  CTTextSizeCalculateDemoViewController.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/18.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "CTTextSizeCalculateDemoViewController.h"
#import "YTDrawView.h"
#import <Masonry.h>

@interface CTTextSizeCalculateDemoViewController ()

@end

@implementation CTTextSizeCalculateDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    {
        CGRect frame = CGRectMake(0, 20, self.view.bounds.size.width, 100);
        YTDrawView *textDrawView = [[YTDrawView alloc] initWithFrame:frame];
        textDrawView.backgroundColor = [UIColor whiteColor];
        textDrawView.text = @"手动布局手动计算高度：\n这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。";
        textDrawView.textColor = [UIColor redColor];
        textDrawView.font = [UIFont systemFontOfSize:16];
        CGSize size = [textDrawView sizeThatFits:CGSizeMake(frame.size.width, MAXFLOAT)];
        textDrawView.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), size.width, size.height);
        [self.view addSubview:textDrawView];
    }
    
    {
        YTDrawView *textDrawView = [[YTDrawView alloc] initWithFrame:CGRectZero];
        textDrawView.backgroundColor = [UIColor whiteColor];
        textDrawView.text = @"自动布局自动计算高度：\n这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。";
        textDrawView.textColor = [UIColor redColor];
        textDrawView.font = [UIFont systemFontOfSize:16];
        textDrawView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 0);
        [self.view addSubview:textDrawView];
        [textDrawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(200);
        }];
    }
    
    {
        YTDrawView *textDrawView = [[YTDrawView alloc] initWithFrame:CGRectZero];
        textDrawView.backgroundColor = [UIColor whiteColor];
        textDrawView.text = @"自动布局限制高度：\n这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。";
        textDrawView.textColor = [UIColor redColor];
        textDrawView.font = [UIFont systemFontOfSize:16];
        // 这一步很重要，需要传递一个frame，其实在自动布局模式下只要用到width,其它值为0即可
        textDrawView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 0);
        [self.view addSubview:textDrawView];
        [textDrawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(400);
            make.height.mas_equalTo(64);
        }];
    }
}

@end
