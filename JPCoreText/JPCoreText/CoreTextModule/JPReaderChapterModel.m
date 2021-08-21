//
//  JPReaderContextModel.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderChapterModel.h"
#import "JPReaderDataProducer.h"

@implementation JPReaderChapterModel

- (void)dealloc {
    if (_ctFrame) {
        CFRelease(_ctFrame);
    }
}

- (void)addItem:(JPReaderItemModel *)model {
    [self.itemArr addObject:model];
}

- (void)readyDataWithBounds:(CGRect)bounds {
    [self setupAttributedString];
    [self setupCTFrameWithBounds:bounds];
    [self setupPageDataWithBounds:bounds];
}

- (void)setupAttributedString {
    [JPReaderDataProducer createAttributedStringWithChapterModel:self];
}

- (void)setupCTFrameWithBounds:(CGRect)bounds {
    [JPReaderDataProducer createCTFrameWithBounds:bounds chapterModel:self];
}

- (void)setupPageDataWithBounds:(CGRect)bounds {
    [JPReaderDataProducer createPageDataWithBounds:bounds chapterModel:self];
}

- (NSMutableArray<JPReaderItemModel *> *)itemArr {
    if (_itemArr == nil) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}

- (NSMutableArray<NSNumber *> *)locationArr {
    if (_locationArr == nil) {
        _locationArr = [[NSMutableArray alloc] init];
    }
    return _locationArr;
}


- (void)setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame != ctFrame) {
        if (_ctFrame) {
            CTFrameRef oldValue = _ctFrame;
            CFRelease(oldValue);
        }
        _ctFrame = ctFrame;
    }
}

@end
