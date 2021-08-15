//
//  ViewController.m
//  DrawImageDemo
//
//  Created by LJP on 2021/7/31.
//

#import "ViewController.h"
#import "JPLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    JPLabel *label = [[JPLabel alloc] initWithFrame:CGRectMake(0, 0, 160, 200)];
    label.center = self.view.center;
    [self.view addSubview:label];
}

@end
