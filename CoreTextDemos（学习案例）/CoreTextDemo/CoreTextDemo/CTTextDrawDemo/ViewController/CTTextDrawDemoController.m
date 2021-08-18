//
//  CTTextDrawDemoController.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/12.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "CTTextDrawDemoController.h"
#import "CTTextDrawView.h"

@interface CTTextDrawDemoController ()

@end

@implementation CTTextDrawDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    CTTextDrawView *textDrawView = [[CTTextDrawView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    textDrawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textDrawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
