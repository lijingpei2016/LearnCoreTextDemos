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
    //matrix 矩阵 affine transform identity
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //在Y轴上移动 height个单位   coretext的原点是在左下角  而我们平时的ui控件是在左上角
    //Translate 翻译
    CGContextTranslateCTM(context, 0, self.bounds.size.height);

    //Changes the scale of the user coordinate system in a context.
    //在上下文中更改用户坐标系的比例。
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
