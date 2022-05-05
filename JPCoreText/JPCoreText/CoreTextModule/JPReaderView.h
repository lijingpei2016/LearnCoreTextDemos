//
//  JPReaderView.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import <UIKit/UIKit.h>
#import "JPReaderChapterModel.h"

//代理
@protocol JPReaderViewDelegate <NSObject>
@optional
- (void)disDrawRect;
- (void)tapAction;

@end


@interface JPReaderView : UIView
@property (nonatomic, weak) id<JPReaderViewDelegate> delegate;
@property (nonatomic, strong) JPReaderChapterModel *contextModel;
@property (nonatomic, assign) NSInteger index;

@end
