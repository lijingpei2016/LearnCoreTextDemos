//
//  CTTextDrawDemoController.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/12.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "CTImageDrawDemoController.h"
#import "CTImageDrawView.h"
#import "RichTextDataComposer.h"

@interface CTImageDrawDemoController ()
@property (nonatomic, strong) CTImageDrawView *textDrawView;
@end

@implementation CTImageDrawDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    CGRect frame = CGRectMake(0, 100, self.view.bounds.size.width, 400);
    CTImageDrawView *textDrawView = [[CTImageDrawView alloc] initWithFrame:frame];
    
    RichTextDataComposer *dataComposer = [RichTextDataComposer new] ;
    textDrawView.data = [dataComposer richTextDataWithFrame:frame];
    
    textDrawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textDrawView];
    self.textDrawView = textDrawView;
}

@end
