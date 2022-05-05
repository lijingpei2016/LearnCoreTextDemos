//
//  JPReaderViewController.m
//  JPCoreText
//
//  Created by LJP on 2021/8/17.
//

#import "JPReaderPageViewController.h"
#import "JPReaderView.h"
#import "JPReaderDataProducer.h"

@interface JPReaderPageViewController ()<JPReaderViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) JPReaderView *readerView;
@property (nonatomic, strong) UILabel *progressLabel;

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
    [self.view addSubview:self.progressLabel];

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

- (void)disDrawRect {
    self.progressLabel.text = [NSString stringWithFormat:@" %ld / %ld",_index+1,_contextModel.locationArr.count-1];
}

- (void)tapAction {
    //加大字体
    self.contextModel;
}

- (JPReaderView *)readerView {
    if (_readerView == nil) {
        _readerView = [[JPReaderView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, self.view.frame.size.height - 200)];
        _readerView.delegate = self;
    }
    return _readerView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 200, 20)];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    }
    return _titleLabel;
}

- (UILabel *)progressLabel {
    if (_progressLabel == nil) {
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 60, 200, 20)];
        _progressLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    }
    return _progressLabel;
}

@end
