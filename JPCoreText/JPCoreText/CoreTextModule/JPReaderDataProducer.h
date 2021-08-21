//
//  JPReaderAttributedProducer.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#define kItemModelKey @"kItemModelKey"


#import <Foundation/Foundation.h>
#import "JPReaderChapterModel.h"

@interface JPReaderDataProducer : NSObject

+ (void)createAttributedStringWithChapterModel:(JPReaderChapterModel *)model;

+ (void)createCTFrameWithBounds:(CGRect)bounds chapterModel:(JPReaderChapterModel *)model;

+ (void)createPageDataWithBounds:(CGRect)bounds chapterModel:(JPReaderChapterModel *)model;

+ (CTFrameRef)getCTFrameWithBounds:(CGRect)bounds chapterModel:(JPReaderChapterModel *)model index:(NSInteger)index;

@end
