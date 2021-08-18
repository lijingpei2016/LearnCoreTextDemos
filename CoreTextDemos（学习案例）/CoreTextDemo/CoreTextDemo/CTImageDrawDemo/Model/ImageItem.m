//
//  ImageItem.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/12.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "ImageItem.h"

@implementation ImageItem

- (instancetype)initWithImageName:(NSString *)imageName frame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.frame = frame;
    }
    return self;
}

@end
