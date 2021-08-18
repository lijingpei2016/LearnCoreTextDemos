//
//  JPReaderContextModel.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderContextModel.h"
#import "JPAttributedStringProducer.h"

@implementation JPReaderContextModel

- (void)addItem:(JPReaderItemModel *)model {
    [self.itemArr addObject:model];
}

- (void)readyDataWithBounds:(CGRect)bounds {
    [self setupAttributedString];
    [self setupCTFrameWithBounds:bounds];
    [self setupPageDataWithBounds:bounds];
}

- (void)setupAttributedString {
    [JPAttributedStringProducer createAttributedStringWithContextModel:self];
}

- (void)setupCTFrameWithBounds:(CGRect)bounds {
    [JPAttributedStringProducer createCTFrameWithBounds:bounds contextModel:self];
}

- (void)setupPageDataWithBounds:(CGRect)bounds {
    [JPAttributedStringProducer createPageDataWithBounds:bounds contextModel:self];
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

@end
