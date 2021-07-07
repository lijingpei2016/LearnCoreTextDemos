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
    //创建一个上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    //在Y轴上移动 height个单位   coretext的原点是在左下角  而我们平时的ui控件是在左上角
    CGContextTranslateCTM(context, 0, self.bounds.size.height);

    //在上下文中更改用户坐标系的比例。
    CGContextScaleCTM(context, 1, -1);

    // 绘制区域
    CGMutablePathRef path = CGPathCreateMutable();

    //第二个参数是Transform
    CGPathAddRect(path, NULL, self.bounds);

    // 设置配置的字典 比如字体 颜色
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:18],
                                  NSForegroundColorAttributeName: [UIColor orangeColor] };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"Hello CoreText Hello CoreText" attributes:attributes];

    // 存储材料，渲染的frame是根据渲染材料的完整度而得出的，比如我渲染一半或者百分之10，得出来的frame可能是不一样的
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    //这里我的理解是，CTFramesetterRef提供内容，记录了所有文字（要渲染）内容，计算出来的是需要渲染的范围，比如我可以只渲染内容里的一部分，之所以要传一个path是因为我要确定宽，才可以得出高
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, NULL);

    // 在context这个画布里，渲染frame的内容，  相当于context就是一个窗口，frame是幅画的内容，窗口可能可以看到部分、完整、恰好相等的画，如果窗口小，画大，那就只能看到一部分
    CTFrameDraw(frame, context);
}

@end
