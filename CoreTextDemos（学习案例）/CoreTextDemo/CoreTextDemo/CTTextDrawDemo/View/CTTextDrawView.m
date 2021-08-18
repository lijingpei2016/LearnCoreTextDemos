//
//  CTTextDrawView.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/12.
//  Copyright © 2018年 aron. All rights reserved.
//

#import "CTTextDrawView.h"
#import <CoreText/CoreText.h>

@implementation CTTextDrawView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    // 绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    // 绘制的内容属性字符串
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName: [UIColor blueColor]
                                 };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world" attributes:attributes];
    
    // 使用NSMutableAttributedString创建CTFrame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, NULL);
    
    // 使用CTFrame在CGContextRef上下文上绘制
    CTFrameDraw(frame, context);
    
    // 手动释放内存
    CFRelease(framesetter);
    CFRelease(frame);
}

@end
