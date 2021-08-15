//
//  JPLabel.m
//  DrawImageDemo
//
//  Created by LJP on 2021/7/31.
//

#import "JPLabel.h"
#import <CoreText/CoreText.h>

@implementation JPLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    //调整好context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);

    //创建总的attribute
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] init];

    //创建图片的attribute
    //创建ctrundelegatecallbacks
    CTRunDelegateCallbacks callback;
    //http://c.biancheng.net/view/231.html
    //memset() 函数可以说是初始化内存的“万能函数”，通常为新申请的内存进行初始化工作。它是直接操作内存空间，mem即“内存”（memory）的意思。该函数的原型为：
    //# include <string.h>
    //void *memset(void *s, int c, unsigned long n);
    //函数的功能是：将指针变量 s 所指向的前 n 字节的内存单元用一个“整数” c 替换，注意 c 是 int 型。s 是 void* 型的指针变量，所以它可以为任何类型的数据进行初始化。
    memset(&callback, 0, sizeof(CTRunDelegateCallbacks));
    callback.getAscent = getAscentCallback;
    callback.getDescent = getDescentCallback;
    callback.getWidth = getWidthCallback;

    //创建CTRunDelegateRef
    NSDictionary *metaData = @{ @"width": @(160), @"height": @(200) };
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callback, (__bridge_retained void *)(metaData));

    unichar placeholderChar = 0xFFFC;
    NSMutableAttributedString *imagePlaceHolderAbs = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithCharacters:&placeholderChar length:1] attributes:nil];

    //设置RunDelegate   给占位字符串 设置 代理 --》RunDelegate
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)imagePlaceHolderAbs, CFRangeMake(0, 1), kCTRunDelegateAttributeName, runDelegate);

    CFRelease(runDelegate);

    [abs appendAttributedString:imagePlaceHolderAbs];

    //创建CTFrameRef
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);

    // 使用NSMutableAttributedString创建CTFrame
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)abs);

    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter, CFRangeMake(0, abs.length), path, NULL);

    CTFrameDraw(ctFrame, context);
    
    CFRelease(ctFramesetter);
    CFRelease(path);

    NSMutableArray *imageFraemArr = [[NSMutableArray alloc] init];

    // CTFrameGetLines获取但CTFrame内容的行数
    NSArray *lines = (NSArray *)CTFrameGetLines(ctFrame);

    // CTFrameGetLineOrigins获取每一行的起始点，保存在lineOrigins数组中
    CGPoint lineOrigins[lines.count];

    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);

    for (int i = 0; i < lines.count; i++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];

        NSArray *runs = (NSArray *)CTLineGetGlyphRuns(line);

        for (int j = 0; j < runs.count; j++) {
            CTRunRef run = (__bridge CTRunRef)(runs[j]);
            NSDictionary *attributes = (NSDictionary *)CTRunGetAttributes(run);
            if (!attributes) {
                continue;
            }

            // 从属性中获取到创建属性字符串使用CFAttributedStringSetAttribute设置的delegate值
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (!delegate) {
                continue;
            }

            // CTRunDelegateGetRefCon方法从delegate中获取使用CTRunDelegateCreate初始时候设置的元数据
            NSDictionary *metaData = (NSDictionary *)CTRunDelegateGetRefCon(delegate);
            if (!metaData) {
                continue;
            }

            // 找到代理则开始计算图片位置信息
            CGFloat ascent;
            CGFloat desent;
            // 可以直接从metaData获取到图片的宽度和高度信息
            CGFloat width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &desent, NULL);

            // CTLineGetOffsetForStringIndex获取CTRun的起始位置
            CGFloat xOffset = lineOrigins[i].x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            CGFloat yOffset = lineOrigins[i].y;

            // 更新ImageItem对象的位置
            CGRect imageFrame = CGRectMake(xOffset, yOffset, width, ascent + desent);

            [imageFraemArr addObject:@(imageFrame)];
        }
    }

    for (id temp in imageFraemArr) {
        CGRect frame = (CGRect)[temp CGRectValue];
        CGContextDrawImage(context, frame, [UIImage imageNamed:@"123"].CGImage);
    }
}

// MARK: - CTRunDelegateCallbacks 回调方法
static CGFloat getAscentCallback(void *ref)
{
    float height = [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
    return height;
}

static CGFloat getDescentCallback(void *ref)
{
    return 0;
}

static CGFloat getWidthCallback(void *ref)
{
    float width = [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
    return width;
}

@end
