//
//  JPReaderView.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import <UIKit/UIKit.h>
#import "JPReaderChapterModel.h"

@interface JPReaderView : UIView

@property (nonatomic, strong) JPReaderChapterModel *contextModel;
@property (nonatomic, assign) NSInteger index;

@end
