//
//  JPLabel.m
//  03_点击事件demo
//
//  Created by LJP on 2021/8/14.
//

#import "JPLabel.h"
#import <CoreText/CoreText.h>

typedef void (^ClickActionHandler)(id obj);

@interface JPLabel ()

@property (nonatomic, copy) ClickActionHandler clickActionHandler;
@property (nonatomic, assign) CGRect uiKitClickableFrame;

@end

@implementation JPLabel

- (void)drawRect:(CGRect)rect {
    //调整好context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);

    CGMutablePathRef path = CGPathCreateMutable();

    CGPathAddRect(path, NULL, self.bounds);

    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:@"点击事情0123456789"];
    ClickActionHandler handler = ^(id obj) {
        NSLog(@"点击了规定好的区域");
    };

    self.clickActionHandler = handler;

    NSDictionary *param = @{ @"block": handler };

    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)abs, CFRangeMake(0, abs.length), (CFStringRef)@"param", (__bridge CFTypeRef)(param));

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)abs);

    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, abs.length), path, NULL);

    CTFrameDraw(frame, context);

    //=========== 计算位置 ==============

    NSArray *lines = (NSArray *)CTFrameGetLines(frame);

    CGPoint lineOrigins[lines.count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);

    for (int i = 0; i < lines.count; i++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray *runs = (NSArray *)CTLineGetGlyphRuns(line);

        for (int j = 0; j < runs.count; j++) {
            CTRunRef run = (__bridge CTRunRef)(runs[j]);
            NSDictionary *param = (NSDictionary *)CTRunGetAttributes(run);

            // 获取CTRun的信息
            CGFloat ascent;
            CGFloat desent;
            // 可以直接从metaData获取到图片的宽度和高度信息
            CGFloat width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &desent, NULL);
            CGFloat height = ascent + desent;

            // CTLineGetOffsetForStringIndex获取CTRun的起始位置
            CGFloat xOffset = lineOrigins[i].x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            CGFloat yOffset = self.bounds.size.height - lineOrigins[i].y - ascent;

            CGRect uiKitClickableFrame = CGRectMake(xOffset, yOffset, width, height);

            self.uiKitClickableFrame = uiKitClickableFrame;

//            UIView *coverView = [[UIView alloc] initWithFrame:uiKitClickableFrame];
//            coverView.tag = 100;
//            coverView.backgroundColor = [UIColor colorWithRed:0.3 green:1 blue:1 alpha:0.3];
//            coverView.layer.cornerRadius = 3;
//            [self addSubview:coverView];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = event.allTouches.anyObject;
    if (touch.view == self) {
        CGPoint point = [touch locationInView:touch.view];
        BOOL contains = CGRectContainsPoint(self.uiKitClickableFrame, point);

        if (contains) {
            if (self.clickActionHandler) {
                self.clickActionHandler(nil);
            }
        }
    }
}

@end
