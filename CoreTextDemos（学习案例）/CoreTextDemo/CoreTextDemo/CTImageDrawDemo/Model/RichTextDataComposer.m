//
//  RichTextDataComposer.m
//  CoreTextDemo
//
//  Created by aron on 2018/7/1
//  Copyright © 2018年 aron. All rights reserved.
//

#import "RichTextDataComposer.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "ImageItem.h"

@interface RichTextDataComposer ()
@property (nonatomic, strong) RichTextData *richTextData;
@end

@implementation RichTextDataComposer

- (RichTextData *)richTextDataWithFrame:(CGRect)frame {
    if (!_richTextData) {
        _richTextData = [RichTextData new];
        _richTextData.attributeString = [self attributeStringForDraw];
        // 先计算CTFrame，然后根据CTFrame计算图片所在的位置
        CTFrameRef ctFrame = [self ctFrameWithAttributeString:_richTextData.attributeString frame:frame];
        _richTextData.ctFrame = ctFrame;
        // 设置图片数据
        [_richTextData.images addObject:[[ImageItem alloc] initWithImageName:@"tata_popup_img_rise" frame:CGRectZero]];
        // 计算图片的位置，更新_richTextData.images数组中的数据
        [self calculateImagePosition];
    }
    return _richTextData;
}

- (NSAttributedString *)attributeStringForDraw {
    NSMutableAttributedString *attributeString = [NSMutableAttributedString new];
    
    // 添加文字
    NSAttributedString *textAttributeString = [[NSAttributedString alloc] initWithString:@"11Hello world 11" attributes:[self defaultTextAttributes]];
    [attributeString appendAttributedString:textAttributeString];
    
    textAttributeString = [[NSAttributedString alloc] initWithString:@"HelloWorld" attributes:[self boldHighlightedTextAttributes]];
    [attributeString appendAttributedString:textAttributeString];
    
    // 添加链接
    NSAttributedString *linkAttributeString = [[NSAttributedString alloc] initWithString:@"www.baidu.com" attributes:[self linkTextAttributes]];
    [attributeString appendAttributedString:linkAttributeString];

    // 添加图片
    [attributeString appendAttributedString:[self imageAttributeString]];
    
    // 添加文字
    textAttributeString = [[NSAttributedString alloc] initWithString:@"22Hello world Hello world Hello world Hello world Hello world Hello world22" attributes:[self defaultTextAttributes]];
    [attributeString appendAttributedString:textAttributeString];

    return attributeString;
}

- (NSAttributedString *)imageAttributeString {
    // 1 创建CTRunDelegateCallbacks
    CTRunDelegateCallbacks callback;
    memset(&callback, 0, sizeof(CTRunDelegateCallbacks));
    callback.getAscent = getAscent;
    callback.getDescent = getDescent;
    callback.getWidth = getWidth;
    
    // 2 创建CTRunDelegateRef
    NSDictionary *metaData = @{@"width": @120, @"height": @140};
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callback, (__bridge_retained void *)(metaData));
    
    // 3 设置占位使用的图片属性字符串
    // 参考：https://en.wikipedia.org/wiki/Specials_(Unicode_block)  U+FFFC ￼ OBJECT REPLACEMENT CHARACTER, placeholder in the text for another unspecified object, for example in a compound document.
    unichar objectReplacementChar = 0xFFFC;
    NSMutableAttributedString *imagePlaceHolderAttributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithCharacters:&objectReplacementChar length:1] attributes:[self defaultTextAttributes]];
    
    // 4 设置RunDelegate代理
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)imagePlaceHolderAttributeString, CFRangeMake(0, 1), kCTRunDelegateAttributeName, runDelegate);
    CFRelease(runDelegate);
    return imagePlaceHolderAttributeString;
}

- (CTFrameRef)ctFrameWithAttributeString:(NSAttributedString *)attributeString frame:(CGRect)frame {
    // 绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, (CGRect){{0, 0}, frame.size});
    
    // 使用NSMutableAttributedString创建CTFrame
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter, CFRangeMake(0, attributeString.length), path, NULL);
    
    CFRelease(ctFramesetter);
    CFRelease(path);
    
    return ctFrame;
}

- (void)calculateImagePosition {
    
    int imageIndex = 0;
    if (imageIndex >= self.richTextData.images.count) {
        return;
    }
    
    // CTFrameGetLines获取但CTFrame内容的行数
    NSArray *lines = (NSArray *)CTFrameGetLines(self.richTextData.ctFrame);
    // CTFrameGetLineOrigins获取每一行的起始点，保存在lineOrigins数组中
    CGPoint lineOrigins[lines.count];
    CTFrameGetLineOrigins(self.richTextData.ctFrame, CFRangeMake(0, 0), lineOrigins);
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
            ImageItem *imageItem = self.richTextData.images[imageIndex];
            imageItem.frame = CGRectMake(xOffset, yOffset, width, ascent + desent);
            
            imageIndex ++;
            if (imageIndex >= self.richTextData.images.count) {
                return;
            }
        }
    }
}

// MARK: - CTRunDelegateCallbacks 回调方法
static CGFloat getAscent(void *ref) {
    float height = [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
    return height;
}

static CGFloat getDescent(void *ref) {
    return 0;
}

static CGFloat getWidth(void *ref) {
    float width = [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
    return width;
}

// MARK: - Config
- (NSDictionary *)defaultTextAttributes {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName: [UIColor cyanColor]
                                 };
    return attributes;
}

- (NSDictionary *)boldHighlightedTextAttributes {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:24],
                                 NSForegroundColorAttributeName: [UIColor redColor],
                                 };
    return attributes;
}

- (NSDictionary *)linkTextAttributes {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName: [UIColor blueColor],
                                 NSUnderlineStyleAttributeName: @1,
                                 NSUnderlineColorAttributeName: [UIColor blueColor],
                                 };
    return attributes;
}

// MARK: - Test
- (void)testCTFrame:(CTFrameRef)ctFrame {
    NSLog(@"==========testCTFrame==========");
    CGPathRef path = CTFrameGetPath(ctFrame);
    CGRect pathFrame = CGPathGetBoundingBox(path);
    NSLog(@"path = %@", NSStringFromCGRect(pathFrame));
    
    CFRange visibleStringRange = CTFrameGetVisibleStringRange(ctFrame);
    NSLog(@"VisibleStringRange = (%@, %@)", @(visibleStringRange.location), @(visibleStringRange.length));
    
    CFRange stringRange = CTFrameGetStringRange(ctFrame);
    NSLog(@"StringRange = (%@, %@)", @(stringRange.location), @(stringRange.length));

    NSDictionary *ctFrameAttributes = (NSDictionary *)CTFrameGetFrameAttributes(ctFrame);
    NSLog(@"FrameAttributes = %@", ctFrameAttributes);
}

- (void)testCTLine:(CTLineRef)ctLine {
    NSLog(@"==========testCTLine==========");
    CFIndex count = CTLineGetGlyphCount(ctLine);
    NSLog(@"GlyphCount = %@", @(count));
    
    CFRange stringRange = CTLineGetStringRange(ctLine);
    NSLog(@"StringRange = (%@, %@)", @(stringRange.location), @(stringRange.length));

    CGRect lineBounds = CTLineGetBoundsWithOptions(ctLine, kCTLineBoundsUseGlyphPathBounds);
    NSLog(@"lineBounds = %@", NSStringFromCGRect(lineBounds));
    
    double trailingWhitespace = CTLineGetTrailingWhitespaceWidth(ctLine);
    NSLog(@"trailingWhitespace = %@", @(trailingWhitespace));
    
    CGRect imageBounds = CTLineGetImageBounds(ctLine, NULL);
    NSLog(@"imageBounds = %@", NSStringFromCGRect(imageBounds));
}

@end
