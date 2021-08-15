//
//  JPReaderLayer.h
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import <QuartzCore/QuartzCore.h>
#import "JPReaderContextModel.h"

@interface JPReaderLayer : CALayer

@property (nonatomic, strong) JPReaderContextModel *contextModel;

@end
