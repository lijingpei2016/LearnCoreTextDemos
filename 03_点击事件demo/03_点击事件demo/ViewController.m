//
//  ViewController.m
//  03_点击事件demo
//
//  Created by LJP on 2021/8/14.
//

#import "ViewController.h"
#import "JPLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    JPLabel *l = [[JPLabel alloc] initWithFrame:CGRectMake(0, 100, 200, 50)];
    l.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8];
    l.userInteractionEnabled = YES;
    
    [self.view addSubview:l];
    
    BOOL contains = CGRectContainsPoint(CGRectMake(30, 30, 100, 100), CGPointMake(50, 50));
    NSLog(@"1");

}


@end
