//
//  JPReaderViewController.m
//  JPCoreText
//
//  Created by LJP on 2021/8/17.
//

#import "JPReaderPageViewController.h"
#import "JPReaderView.h"
#import "JPReaderDataProducer.h"

@interface JPReaderPageViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) JPReaderView *readerView;

@end

@implementation JPReaderPageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.readerView];
}

- (void)setContextModel:(JPReaderChapterModel *)contextModel {
    _contextModel = contextModel;
    
    self.readerView.contextModel = contextModel;
    
    self.titleLabel.text = contextModel.chapterName;

}

- (void)setIndex:(NSInteger)index {
    _index = index;
    self.readerView.index = index;
}

- (JPReaderView *)readerView {
    if (_readerView == nil) {
        _readerView = [[JPReaderView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, self.view.frame.size.height - 200)];
    }
    return _readerView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 200, 20)];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    }
    return _titleLabel;
}

@end
