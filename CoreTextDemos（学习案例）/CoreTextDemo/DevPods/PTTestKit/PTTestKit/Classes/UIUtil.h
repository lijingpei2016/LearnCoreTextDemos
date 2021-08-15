//
//  UIUtil.h
//  easycut
//
//  Created by heyuan on 16/2/5.
//  Copyright © 2016年 grape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SKStoreProductViewControllerDelegate;

@interface UIUtil : NSObject

+ (UIViewController *)topPresentedViewController;
+ (UIViewController*)mm_rootViewController;
+ (void)dismissAllPresentedViewControllers;
+ (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated hidesBottomBar:(BOOL)hidesBottomBar;


@end
