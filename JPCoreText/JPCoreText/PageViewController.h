//
//  JPReaderViewController.h
//  JPCoreText
//
//  Created by LJP on 2021/8/17.
//

#import <UIKit/UIKit.h>
#import "JPReaderContextModel.h"

@interface PageViewController : UIViewController

@property (nonatomic, strong) JPReaderContextModel *contextModel;
@property (nonatomic, assign) NSInteger index;

@end
