//
//  JPReaderBaseModel.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderItemModel.h"

@implementation JPReaderItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:16.0f];
        _fontSize = 16.0f;
        _textColor = [UIColor blackColor];
        _lineSpace = 8.0f;
    }
    return self;
}

@end
