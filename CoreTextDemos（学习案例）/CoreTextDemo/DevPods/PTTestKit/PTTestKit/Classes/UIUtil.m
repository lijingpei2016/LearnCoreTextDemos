//
//  UIUtil.m
//  easycut
//
//  Created by heyuan on 16/2/5.
//  Copyright © 2016年 grape. All rights reserved.
//

#import "UIUtil.h"

#define kAppWindow              ([[UIApplication sharedApplication] delegate].window)

static BOOL isPresenting = NO;
#define checkPresenting() {\
if (isPresenting) {\
return;\
}\
isPresenting = YES;\
}while(0)
#define endCheckPresenting()   (isPresenting = NO)

@implementation UIUtil

+ (UIViewController *)topPresentedViewController
{
    UIViewController *topController = kAppWindow.rootViewController;
    
    while ([topController presentedViewController] != nil) {
        topController = [topController presentedViewController];
    }
    
    return topController;
}

+ (UIViewController*)mm_rootViewController {
    UIViewController *topViewController = [UIUtil topPresentedViewController];
    if ([topViewController isKindOfClass:[UITabBarController class]]) {
        topViewController = ((UITabBarController *)topViewController).selectedViewController;
    }
    return topViewController;
}

+ (void)dismissAllPresentedViewControllers {
    checkPresenting();
    UIViewController *topPresentedViewController = [UIUtil topPresentedViewController];
    if (topPresentedViewController != kAppWindow.rootViewController) {
        [topPresentedViewController dismissViewControllerAnimated:NO completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            endCheckPresenting();
            [UIUtil dismissAllPresentedViewControllers];
        });
    } else {
        endCheckPresenting();
    }
}

+ (void)backToMainRoot {
    [self backToMainRootCompletion:nil];
}

+ (void)backToMainRootCompletion:(void (^)(void))block {
    checkPresenting();
    UIViewController *topPresentedViewController = [UIUtil topPresentedViewController];
    if (topPresentedViewController != kAppWindow.rootViewController) {
        [topPresentedViewController dismissViewControllerAnimated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                endCheckPresenting();
                [UIUtil backToMainRootCompletion:block];
            });
        }];
    } else {
        if ([kAppWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)kAppWindow.rootViewController popToRootViewControllerAnimated:YES];
        } else if ([kAppWindow.rootViewController isKindOfClass:[UITabBarController class]]){
            UITabBarController* tabVC = (UITabBarController *)kAppWindow.rootViewController;
            UINavigationController * navVC = (UINavigationController *)tabVC.selectedViewController;
            [navVC popToRootViewControllerAnimated:YES];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
            endCheckPresenting();
        });
    }
}

+ (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    checkPresenting();
    
    UIViewController *topPresentedViewController = [UIUtil topPresentedViewController];
//    topPresentedViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
//    viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    if (topPresentedViewController != viewController) {
        [topPresentedViewController presentViewController:viewController animated:animated completion:^{
            if (animated) {
                if (completion) {
                    completion();
                }
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion();
                    }
                });
            }
        }];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        endCheckPresenting();
    });
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated hidesBottomBar:(BOOL)hidesBottomBar {
    UIViewController *topViewController = [UIUtil topPresentedViewController];
    if ([topViewController isKindOfClass:[UITabBarController class]]) {
        viewController.hidesBottomBarWhenPushed = hidesBottomBar;
        topViewController = ((UITabBarController *)topViewController).selectedViewController;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)topViewController pushViewController:viewController animated:animated];
        } else {
            [self presentViewController:viewController animated:animated completion:nil];
        }
    } else if ([topViewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)topViewController pushViewController:viewController animated:animated];
    } else {
        if (topViewController.navigationController) {
            [topViewController.navigationController pushViewController:viewController animated:animated];
        } else {
            [self presentViewController:viewController animated:animated completion:nil];
        }
    }
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated hidesBottomBar:YES];
}

+ (void)pushViewController:(UIViewController *)viewController {
    [self pushViewController:viewController animated:YES];
}

@end
