//
//  JPReaderAttributedProducer.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "JPAttributedStringProducer.h"

@implementation JPAttributedStringProducer

/// 根据总model生成AttributedString
+ (NSMutableAttributedString *)createAttributedStringWithContextModel:(JPReaderContextModel *)model {
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] init];

    for (JPReaderItemModel *item in model.itemArr) {
        NSMutableAttributedString *itemString = [JPAttributedStringProducer createAttributedStringWithItemModel:item];
        if (itemString) {
            [aAttrString appendAttributedString:itemString];
        }
    }

    return aAttrString;
}

/// 根据itemModel生成单个节点的AttributedString
+ (NSMutableAttributedString *)createAttributedStringWithItemModel:(JPReaderItemModel *)model {
    NSMutableAttributedString *aAttrString;

    if (model.type == JPReaderItemModelTypeText) {
        NSDictionary *param = [JPAttributedStringProducer creatAttributeParamWithItemModel:model];
        aAttrString = [[NSMutableAttributedString alloc] initWithString:model.text attributes:param];
    } else if (model.type == JPReaderItemModelTypeImage) {
        aAttrString = [JPAttributedStringProducer creatImageAttributeWithItemModel:model];
    } else if (model.type == JPReaderItemModelTypeLine) {
        NSLog(@"这里写有下划线的");
    } else {
        NSLog(@"出现未定义的类型");
    }

    return aAttrString;
}

/// 生成一个常用的字典
+ (NSDictionary *)creatAttributeParamWithItemModel:(JPReaderItemModel *)model {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    [dict setValue:model.font forKey:NSFontAttributeName];
    [dict setValue:model.textColor forKey:NSForegroundColorAttributeName];

    //剩下的后面可以补充

    return dict.copy;
}

/// 生成一个图片的占位图
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

    CFRelease(runDelegate);
    return imagePlaceHolderAbs;
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
