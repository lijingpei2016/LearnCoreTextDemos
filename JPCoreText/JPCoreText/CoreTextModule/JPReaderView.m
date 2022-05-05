//
//  JPReaderView.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderView.h"
#import "JPReaderDataProducer.h"

@interface JPReaderView ()

@property (nonatomic, strong)UIView *coverView;

@end

@implementation JPReaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        //长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        
        //点击手势
        UITapGestureRecognizer *tapPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];

        [self addGestureRecognizer:longPress];
        [self addGestureRecognizer:tapPress];
    }
    return self;
}

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

    CTFrameRef ctFream = [JPReaderDataProducer getCTFrameWithBounds:self.bounds chapterModel:self.contextModel index:self.index];

    CTFrameDraw(ctFream, context);

    if (ctFream) {
        CFRelease(ctFream);
    }
    
    //判断代理是否实现
    if ([self.delegate respondsToSelector:@selector(disDrawRect)]) {
        [self.delegate disDrawRect];
    }
}


- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan || longPress.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [longPress locationInView:self];
        [self getClickRunWithPoint:point];
    }else {
        [self _coverViewHidden];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    //判断代理是否实现
    if ([self.delegate respondsToSelector:@selector(tapAction)]) {
        [self.delegate tapAction];
    }
}

- (void)_coverViewHidden {
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
}

- (void)getClickRunWithPoint:(CGPoint)point {
    
    if (self.coverView.superview) {
        return;
    }
        
    CTFrameRef frame = [JPReaderDataProducer getCTFrameWithBounds:self.bounds chapterModel:self.contextModel index:self.index];
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
                UIView *coverView = [[UIView alloc] initWithFrame:clickableFrame];
                coverView.backgroundColor = [UIColor colorWithRed:0.3 green:1 blue:1 alpha:0.3];
                coverView.layer.cornerRadius = 3;
                [self addSubview:coverView];
                self.coverView = coverView;
            }
        }
    }
}

@end
