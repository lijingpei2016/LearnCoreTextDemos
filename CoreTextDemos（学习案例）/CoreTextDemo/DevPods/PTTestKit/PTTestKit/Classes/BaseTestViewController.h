//
//  BaseTestViewController.h
//  EffectiveOCDemo
//
//  Created by aron on 2017/4/18.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ActionCellType) {
    ActionCellTypeNone = -1,
    ActionCellTypeCustomCallback = 0,
    ActionCellTypePushViewController = 1,
};

@interface ActionCellModel : NSObject

@property (nonatomic, copy) NSString* actionName;
@property (nonatomic, copy) NSString* detailText;
@property (nonatomic, copy) void(^actionCallBack)(void);
@property (nonatomic, assign) ActionCellType actionCellType;

-(instancetype)initWithActionName:(NSString*)actionName actionCallBack:(void(^)(void))callback;

@end


@interface BaseTestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView* tableView;

/**
 添加一个Cell和Cell对应的点击事件回调block
 @param actionName Cell显示名称
 @param callback 点击事件回调block
 */
- (void)addActionWithName:(NSString*)actionName callback:(void(^)(void))callback;


/**
 添加一个Cell和Cell对应的点击跳转到的ViewController的class
 @param destViewControllClass 转到的ViewController的class
 */
- (void)addActionWithDestViewControllClass:(Class)destViewControllClass;

/**
 添加一个Cell和Cell对应的点击跳转到的ViewController的class
 @param detailText 描述文字
 @param destViewControllClass 转到的ViewController的class
 */
- (void)addActionWithDetailText:(NSString *)detailText destViewControllClass:(Class)destViewControllClass;

/**
 添加一个Cell和Cell对应的点击跳转到的ViewController的class
 @param name Cell显示名称
 @param destViewControllClass 转到的ViewController的class
 */
- (void)addActionWithName:(NSString*)name destViewControllClass:(Class)destViewControllClass;

/**
 添加一个Cell和Cell对应的点击跳转到的ViewController的class
 @param name Cell显示名称
 @param detailText 描述文字
 @param destViewControllClass 转到的ViewController的class
 */
- (void)addActionWithName:(NSString *)name detailText:(NSString *)detailText destViewControllClass:(Class)destViewControllClass;
@end
