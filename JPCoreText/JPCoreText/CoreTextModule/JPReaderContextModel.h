//
//  JPReaderContextModel.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "JPReaderItemModel.h"
#import <CoreText/CoreText.h>

@interface JPReaderContextModel : NSObject

/// 装每个节点数据的数组
@property (nonatomic, strong) NSMutableArray <JPReaderItemModel *> *itemArr;

/// 文本绘制的区域大小
@property (nonatomic, assign) CTFrameRef ctFrame;

- (void)addItem:(JPReaderItemModel *)model;

@end
