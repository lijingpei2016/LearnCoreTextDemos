//
//  JPReaderViewController.h
//  JPCoreText
//
//  Created by LJP on 2021/8/17.
//

#import <UIKit/UIKit.h>
#import "JPReaderChapterModel.h"

@interface JPReaderPageViewController : UIViewController

@property (nonatomic, strong) JPReaderChapterModel *contextModel;
@property (nonatomic, assign) NSInteger index;

@end
