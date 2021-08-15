//
//  ViewController.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "ViewController.h"
#import "JPReaderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    JPReaderView *jpView = [[JPReaderView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];

    JPReaderItemModel *itemModel = [[JPReaderItemModel alloc] init];
    itemModel.type = JPReaderItemModelTypeText;
    itemModel.text = @"12345909595959";

    JPReaderContextModel *contextModel = [[JPReaderContextModel alloc] init];
    [contextModel addItem:itemModel];

    jpView.contextModel = contextModel;
    jpView.backgroundColor = UIColor.orangeColor;

    [self.view addSubview:jpView];
}

@end
