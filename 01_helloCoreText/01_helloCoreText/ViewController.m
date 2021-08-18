//
//  ViewController.m
//  01_helloCoreText
//
//  Created by LJP on 2021/6/23.
//

#import "ViewController.h"
#import "JPLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置不同的宽度 可以知道 其代码实现是尽量都把内容显示出来 而不像之前的label 默认显示一行
    JPLabel *l = [[JPLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    l.center = self.view.center;
    l.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8];
    
    [self.view addSubview:l];
    
}


@end
