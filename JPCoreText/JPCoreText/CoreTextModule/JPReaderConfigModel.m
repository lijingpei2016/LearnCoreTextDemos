//
//  JPReaderConfigModel.m
//  JPCoreText
//
//  Created by LJP on 2021/8/21.
//

#import "JPReaderConfigModel.h"

@implementation JPReaderConfigModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:16.0f];
        _fontSize = 16.0f;
        _textColor = [UIColor blackColor];
        _lineSpace = 9.0f;
    }
    return self;
}

@end
