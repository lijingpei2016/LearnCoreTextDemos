//
//  JPReaderContextModel.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderContextModel.h"

@implementation JPReaderContextModel

- (void)addItem:(JPReaderItemModel *)model {
    [self.itemArr addObject:model];
}

- (NSMutableArray<JPReaderItemModel *> *)itemArr {
    if (_itemArr == nil) {
        _itemArr = [[NSMutableArray alloc] init];
    }
    return _itemArr;
}

@end
