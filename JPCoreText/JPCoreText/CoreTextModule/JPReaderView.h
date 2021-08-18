//
//  JPReaderView.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import <UIKit/UIKit.h>
#import "JPReaderContextModel.h"

@interface JPReaderView : UIView

@property (nonatomic, strong) JPReaderContextModel *contextModel;
@property (nonatomic, assign) NSInteger index;

@end
