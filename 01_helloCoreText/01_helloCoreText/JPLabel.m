//
//  JPLabel.m
//  01_helloCoreText
//
//  Created by LJP on 2021/6/23.
//

#import "JPLabel.h"
#import <CoreText/CoreText.h>

@implementation JPLabel

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);

    // 绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);

    // 绘制的内容属性字符串
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:18],
                                  NSForegroundColorAttributeName: [UIColor orangeColor] };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"Hello CoreText Hello CoreText" attributes:attributes];

    // 使用NSMutableAttributedString创建CTFrame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, NULL);

    // 使用CTFrame在CGContextRef上下文上绘制
    CTFrameDraw(frame, context);
}

@end
