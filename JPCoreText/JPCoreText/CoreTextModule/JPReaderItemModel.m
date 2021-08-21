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
        _configModel = [[JPReaderConfigModel alloc] init];
    }
    return self;
}

@end
