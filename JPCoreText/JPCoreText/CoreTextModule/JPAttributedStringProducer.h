//
//  JPReaderAttributedProducer.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#define kItemModelKey @"kItemModelKey"


#import <Foundation/Foundation.h>
#import "JPReaderContextModel.h"

@interface JPAttributedStringProducer : NSObject

+ (void)createAttributedStringWithContextModel:(JPReaderContextModel *)model;

+ (void)createCTFrameWithBounds:(CGRect)bounds contextModel:(JPReaderContextModel *)model;

+ (void)createPageDataWithBounds:(CGRect)bounds contextModel:(JPReaderContextModel *)model;

+ (CTFrameRef)getCTFrameWithBounds:(CGRect)bounds contextModel:(JPReaderContextModel *)model index:(NSInteger)index;

@end
