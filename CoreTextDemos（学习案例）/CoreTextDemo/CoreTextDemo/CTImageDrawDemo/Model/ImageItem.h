//
//  ImageItem.h
//  CoreTextDemo
//
//  Created by aron on 2018/7/12.
//  Copyright © 2018年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageItem : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) CGRect frame;

- (instancetype)initWithImageName:(NSString *)imageName frame:(CGRect)frame;

@end
