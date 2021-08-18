//
//  JPReaderViewController.m
//  JPCoreText
//
//  Created by LJP on 2021/8/17.
//

#import "PageViewController.h"
#import "JPReaderView.h"
#import "JPAttributedStringProducer.h"

@interface PageViewController ()

@property (nonatomic, strong) JPReaderView *readerView;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setContextModel:(JPReaderContextModel *)contextModel {
    _contextModel = contextModel;
    self.readerView.contextModel = contextModel;
    [self.view addSubview:self.readerView];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    self.readerView.index = index;
}

- (JPReaderView *)readerView {
    if (_readerView == nil) {
        _readerView = [[JPReaderView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 200)];
    }
    return _readerView;
}

@end
