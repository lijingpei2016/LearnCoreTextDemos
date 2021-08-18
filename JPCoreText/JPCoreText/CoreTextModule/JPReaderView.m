//
//  JPReaderView.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderView.h"
#import "JPAttributedStringProducer.h"

@interface JPReaderView ()

@end

@implementation JPReaderView

- (void)drawRect:(CGRect)rect {
    if (self.contextModel == nil) {
        return;
    }

    [self.contextModel readyDataWithBounds:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    [[UIColor whiteColor] setFill];
    CGContextFillRect(context, rect);

    CTFrameRef ctFream = [JPAttributedStringProducer getCTFrameWithBounds:self.bounds contextModel:self.contextModel index:self.index];

    CTFrameDraw(ctFream, context);

    if (ctFream) {
        CFRelease(ctFream);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = event.allTouches.anyObject;
    if (touch.view == self) {
        CGPoint point = [touch locationInView:touch.view];
        [self getClickRunWithPoint:point];
    }
}

- (void)getClickRunWithPoint:(CGPoint)point {
    CTFrameRef frame = [JPAttributedStringProducer getCTFrameWithBounds:self.bounds contextModel:self.contextModel index:self.index];

    NSArray *lines = (NSArray *)CTFrameGetLines(frame);

    CGPoint lineOrigins[lines.count];

    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);

    for (int i = 0; i < lines.count; i++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];

        NSArray *runs = (NSArray *)CTLineGetGlyphRuns(line);

        for (int j = 0; j < runs.count; j++) {
            CTRunRef run = (__bridge CTRunRef)(runs[j]);
            
            NSDictionary *param = (NSDictionary *)CTRunGetAttributes(run);
            JPReaderItemModel *model = param[kItemModelKey];

            CGFloat ascent;
            CGFloat desent;
            CGFloat width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &desent, NULL);
            CGFloat height = ascent + desent;

            // CTLineGetOffsetForStringIndex获取CTRun的起始位置
            CGFloat xOffset = lineOrigins[i].x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            CGFloat yOffset = self.bounds.size.height - lineOrigins[i].y - ascent;

            CGRect clickableFrame = CGRectMake(xOffset, yOffset, width, height);

            BOOL contains = CGRectContainsPoint(clickableFrame, point);

            if (contains) {
                if (model.clickActionHandler) {
                    model.clickActionHandler(nil);
                }else {
                    UIView *coverView = [[UIView alloc] initWithFrame:clickableFrame];
                    coverView.backgroundColor = [UIColor colorWithRed:0.3 green:1 blue:1 alpha:0.3];
                    coverView.layer.cornerRadius = 3;
                    [self addSubview:coverView];
                    
                    [UIView animateWithDuration:1 animations:^{
                        coverView.alpha = 0;
                    }completion:^(BOOL finished) {
                        [coverView removeFromSuperview];
                    }];
                }
            }
        }
    }
}

@end
