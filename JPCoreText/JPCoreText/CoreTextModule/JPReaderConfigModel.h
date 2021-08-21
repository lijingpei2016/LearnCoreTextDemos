//
//  JPReaderConfigModel.h
//  JPCoreText
//
//  Created by LJP on 2021/8/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JPReaderConfigModel : NSObject

/// 字体
@property (nonatomic, strong) UIFont *font;

/// 字体大小 可能不需要
@property (nonatomic, assign) CGFloat fontSize;

/// 字体颜色
@property (nonatomic, strong) UIColor *textColor;

/// 字体行间距
@property (nonatomic, assign) CGFloat lineSpace;

@end
