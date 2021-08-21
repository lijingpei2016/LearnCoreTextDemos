//
//  JPReaderAttributedProducer.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPReaderDataProducer.h"

@implementation JPReaderDataProducer

/// 根据总model生成AttributedString
+ (void)createAttributedStringWithChapterModel:(JPReaderChapterModel *)model {
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] init];

    for (JPReaderItemModel *item in model.itemArr) {
        NSMutableAttributedString *itemString = [JPReaderDataProducer createAttributedStringWithItemModel:item];
        if (itemString) {
            [aAttrString appendAttributedString:itemString];
        }
    }

    model.attrString = aAttrString;
}

#pragma mark - 构建方法
/// 根据itemModel生成单个节点的AttributedString
+ (NSMutableAttributedString *)createAttributedStringWithItemModel:(JPReaderItemModel *)model {
    NSMutableAttributedString *aAttrString;

    if (model.type == JPReaderItemModelTypeText) {
        aAttrString = [JPReaderDataProducer creatTextAttributeWithItemModel:model];
    } else if (model.type == JPReaderItemModelTypeImage) {
        aAttrString = [JPReaderDataProducer creatImageAttributeWithItemModel:model];
    } else if (model.type == JPReaderItemModelTypeLine) {
        NSLog(@"这里写有下划线的");
    } else {
        NSLog(@"警告:出现未定义的类型");
    }

    return aAttrString;
}

/// 生成一个常用的字典
+ (NSDictionary *)creatAttributeParamWithItemModel:(JPReaderItemModel *)model {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    [dict setValue:model.configModel.font forKey:NSFontAttributeName];
    [dict setValue:model.configModel.textColor forKey:NSForegroundColorAttributeName];

    //间距
    CGFloat lineSpace = model.configModel.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {
            kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace
        },
        {
            kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpace
        },
        {
            kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace
        }
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;

    //剩下的后面可以补充

    return dict.copy;
}

/// 创建文字的富文本
+ (NSMutableAttributedString *)creatTextAttributeWithItemModel:(JPReaderItemModel *)model {
    NSDictionary *param = [JPReaderDataProducer creatAttributeParamWithItemModel:model];
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:model.text attributes:param];

    //把model存储起来
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)aAttrString, CFRangeMake(0, aAttrString.length), (CFStringRef)kItemModelKey, (__bridge CFTypeRef)(model));

    return aAttrString;
}

/// 生成一个图片的占位图的富文本
+ (NSMutableAttributedString *)creatImageAttributeWithItemModel:(JPReaderItemModel *)model {
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    //设置代理版本 这个不是很理解
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    // 根据配置的信息创建代理
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callbacks, (__bridge void *)@{ @"height": @(model.imageH), @"width": @(model.imageW) });

    //使用0xFFFC作为空白占位符
    unichar placeholderChar = 0xFFFC;

    NSMutableAttributedString *imagePlaceHolderAbs = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithCharacters:&placeholderChar length:1] attributes:nil];

    //设置RunDelegate   给占位字符串 设置 代理 --》RunDelegate
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)imagePlaceHolderAbs, CFRangeMake(0, 1), kCTRunDelegateAttributeName, runDelegate);

    //把model存储起来
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)imagePlaceHolderAbs, CFRangeMake(0, imagePlaceHolderAbs.length), (CFStringRef)kItemModelKey, (__bridge CFTypeRef)(model));

    if (runDelegate) {
        CFRelease(runDelegate);
    }

    return imagePlaceHolderAbs;
}

/// 绘画之前的准备
+ (void)createCTFrameWithBounds:(CGRect)bounds chapterModel:(JPReaderChapterModel *)model {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, (CGRect) { { 0, 0 }, bounds.size });

    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)model.attrString);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter, CFRangeMake(0, model.attrString.length), path, NULL);

    model.ctFrame = ctFrame;

    if (path) {
        CFRelease(path);
    }

    if (ctFramesetter) {
        CFRelease(ctFramesetter);
    }
}

+ (void)createPageDataWithBounds:(CGRect)bounds chapterModel:(JPReaderChapterModel *)model {
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    CFRange range = CFRangeMake(0, 0);
    NSUInteger rangeOffset = 0;
    [model.locationArr removeAllObjects];

    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)model.attrString);

    do {
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(rangeOffset, 0), path, NULL);
        range = CTFrameGetVisibleStringRange(frame);
        rangeOffset += range.length;
        [model.locationArr addObject:@(range.location)];
        if (frame) {
            CFRelease(frame);
        }
    } while (range.location + range.length < model.attrString.length);

    NSNumber *last = model.locationArr.lastObject;
    if (model.attrString.length > last.integerValue) {
        [model.locationArr addObject:@(model.attrString.length)];
    }

    if (path) {
        CFRelease(path);
    }
    if (frameSetter) {
        CFRelease(frameSetter);
    }
}

+ (CTFrameRef)getCTFrameWithBounds:(CGRect)bounds chapterModel:(JPReaderChapterModel *)model index:(NSInteger)index {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, (CGRect) { { 0, 0 }, bounds.size });

    NSInteger loc = [model.locationArr[index] integerValue];
    NSInteger len = [model.locationArr[index + 1] integerValue] - [model.locationArr[index] integerValue];

    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)model.attrString);

    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter, CFRangeMake(loc, len), path, NULL);

    if (path) {
        CFRelease(path);
    }

    if (ctFramesetter) {
        CFRelease(ctFramesetter);
    }

    return ctFrame;
}

#pragma mark - CTRunDelegateCallback

/**
 *  上升高度回调函数
 */
static CGFloat ascentCallback(void *ref)
{
    float height = [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
    return height;
}

/**
 *  下降高度回调函数
 */
static CGFloat descentCallback(void *ref)
{
    return 0;
}

/**
 *  文本宽度回调函数
 */
static CGFloat widthCallback(void *ref)
{
    float width = [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
    return width;
}

@end
