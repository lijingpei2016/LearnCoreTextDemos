//
//  JPReaderView.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderView.h"
#import "JPAttributedStringProducer.h"

@interface JPReaderView ()

@property (nonatomic, strong) JPReaderLayer *JPLayer;

@end

@implementation JPReaderView

//- (void)setContextModel:(JPReaderContextModel *)contextModel {
//    _contextModel = contextModel;
//    [self _setupLayer];
//}
//
//- (void)_setupLayer {
//    self.JPLayer.frame = self.bounds;
//    self.JPLayer.contextModel = _contextModel;
//    [self.layer addSublayer:self.JPLayer];
//}
//
//- (JPReaderLayer *)JPLayer {
//    if (_JPLayer == nil) {
//        _JPLayer = [[JPReaderLayer alloc] init];
//    }
//    return _JPLayer;
//}

- (void)drawRect:(CGRect)rect {
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
