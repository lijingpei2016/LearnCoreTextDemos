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
}


@end
