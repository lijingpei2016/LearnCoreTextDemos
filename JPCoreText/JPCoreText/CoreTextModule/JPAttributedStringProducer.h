//
//  JPReaderAttributedProducer.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "JPReaderContextModel.h"

@interface JPAttributedStringProducer : NSObject

+ (NSMutableAttributedString *)createAttributedStringWithContextModel:(JPReaderContextModel *)model;

@end
