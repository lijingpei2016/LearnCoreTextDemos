//
//  JPReaderBaseModel.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "JPReaderConfigModel.h"

typedef void (^ClickHandler)(id obj);

typedef NS_ENUM (NSInteger, JPReaderItemModelType) {
    JPReaderItemModelTypeText  = 0,       // 单纯的文字类型
    JPReaderItemModelTypeImage = 1,       // 图片类型
    JPReaderItemModelTypeLine  = 2,       // 下划线类型
};

/// 记录文本信息的Model
@interface JPReaderItemModel : NSObject

/// 类型
@property (nonatomic, assign) JPReaderItemModelType type;

@property (nonatomic, strong) JPReaderConfigModel *configModel;

/// 图片的路径
@property (nonatomic, copy) NSString *imageURLString;

/// 图片的宽高
@property (nonatomic, assign) NSInteger imageW;
@property (nonatomic, assign) NSInteger imageH;

/// 显示的文字
@property (nonatomic, copy) NSString *text;

/// 点击回调事件
@property (nonatomic, copy) ClickHandler clickActionHandler;

@end
