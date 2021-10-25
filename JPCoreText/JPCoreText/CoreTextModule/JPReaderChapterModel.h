//
//  JPReaderContextModel.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "JPReaderItemModel.h"
#import <CoreText/CoreText.h>

/// 本model为每一章节的model
@interface JPReaderChapterModel : NSObject

@property (nonatomic, copy) NSString *chapterName;

/// 装每个节点数据的数组
@property (nonatomic, strong) NSMutableArray <JPReaderItemModel *> *itemArr;

/// 文本绘制的区域大小
@property (nonatomic, assign) CTFrameRef ctFrame;

/// 总的富文本 （一个章节）
@property (nonatomic, strong) NSMutableAttributedString *attrString;

/// 装分页的数组
@property (nonatomic, strong) NSMutableArray <NSNumber *> *locationArr;

/// 当前的偏移量
@property (nonatomic, assign) NSInteger currentLocation;

- (void)addItem:(JPReaderItemModel *)model;

- (void)readyDataWithBounds:(CGRect)bounds;

@end
