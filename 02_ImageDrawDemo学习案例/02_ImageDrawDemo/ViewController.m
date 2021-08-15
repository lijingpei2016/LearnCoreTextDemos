//
//  ViewController.m
//  02_ImageDrawDemo
//
//  Created by LJP on 2021/7/11.
//

#import "ViewController.h"
#import "CTImageDrawDemoController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    CTImageDrawDemoController *vc = [[CTImageDrawDemoController alloc] init];
    [self.view addSubview:vc.view];
}


@end
