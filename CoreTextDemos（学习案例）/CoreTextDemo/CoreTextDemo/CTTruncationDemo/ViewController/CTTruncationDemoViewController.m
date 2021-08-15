//
//  CTTruncationDemoViewController.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/16.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "CTTruncationDemoViewController.h"
#import "YTDrawView.h"

@interface CTTruncationDemoViewController ()

@end

@implementation CTTruncationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    CGRect frame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
    YTDrawView *textDrawView = [[YTDrawView alloc] initWithFrame:frame];
    textDrawView.backgroundColor = [UIColor whiteColor];
    textDrawView.numberOfLines = 3;
    [textDrawView addString:@"这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。" attributes:self.defaultTextAttributes clickActionHandler:^(id obj) {
    }];
    [self.view addSubview:textDrawView];
    
    NSAttributedString * truncationToken = [[NSAttributedString alloc] initWithString:@"查看更多" attributes:[self truncationTextAttributes]];
    frame = CGRectMake(0, 220, self.view.bounds.size.width, 100);
    textDrawView = [[YTDrawView alloc] initWithFrame:frame];
    textDrawView.backgroundColor = [UIColor whiteColor];
    textDrawView.numberOfLines = 2;
    textDrawView.truncationToken = truncationToken;
    [textDrawView addString:@"这是一个最好的时代，也是一个最坏的时代；这是明智的时代，这是愚昧的时代；这是信任的纪元，这是怀疑的纪元；这是光明的季节，这是黑暗的季节；这是希望的春日，这是失望的冬日；我们面前应有尽有，我们面前一无所有；我们都将直上天堂，我们都将直下地狱。" attributes:self.defaultTextAttributes clickActionHandler:^(id obj) {
    }];
    __weak typeof(textDrawView) weakDrawView = textDrawView;
    textDrawView.truncationActionHandler = ^(id obj) {
        NSLog(@"点击查看更多");
        weakDrawView.numberOfLines = 0;
    };
    [self.view addSubview:textDrawView];

}

// MARK: - Config
- (NSDictionary *)defaultTextAttributes {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                 };
    return attributes;
}

- (NSDictionary *)truncationTextAttributes {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName: [UIColor blueColor]
                                 };
    return attributes;
}

@end
