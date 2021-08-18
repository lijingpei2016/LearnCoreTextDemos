//
//  CTImageDrawView
//  CoreTextDemo
//
//  Created by aron on 2018/7/12.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "CTImageDrawView.h"
#import <CoreText/CoreText.h>
#import "ImageItem.h"

@implementation CTImageDrawView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    // 使用CTFrame在CGContextRef上下文上绘制
    CTFrameDraw(self.data.ctFrame, context);
    
    // 在CGContextRef上下文上绘制图片
    for (int i = 0; i < self.data.images.count; i++) {
        ImageItem *imageItem = self.data.images[i];
        CGContextDrawImage(context, imageItem.frame, [UIImage imageNamed:imageItem.imageName].CGImage);
    }
}

@end
