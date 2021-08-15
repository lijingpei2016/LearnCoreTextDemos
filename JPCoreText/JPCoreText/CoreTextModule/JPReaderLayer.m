//
//  JPReaderLayer.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderLayer.h"
#import "JPAttributedStringProducer.h"

@implementation JPReaderLayer

- (void)setContextModel:(JPReaderContextModel *)contextModel {
    _contextModel = contextModel;
    [self setupUI];
}

- (void)setupUI {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);

    NSMutableAttributedString *attrStr = [JPAttributedStringProducer createAttributedStringWithContextModel:_contextModel];

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);

    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, NULL);

    _contextModel.ctFrame = frame;

    CTFrameDraw(frame, context);

    CFRelease(framesetter);
    CFRelease(frame);
}


@end
