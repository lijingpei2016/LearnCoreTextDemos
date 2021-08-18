//
//  BaseTestViewController.m
//  EffectiveOCDemo
//
//  Created by aron on 2017/4/18.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "BaseTestViewController.h"
#import "UIUtil.h"

@implementation ActionCellModel

-(instancetype)initWithActionName:(NSString*)actionName actionCallBack:(void(^)(void))callback {
    if (self = [super init]) {
        _actionName = actionName;
        _actionCallBack = callback;
    }
    return self;
}

@end



@interface BaseTestViewController ()

@property (nonatomic, strong) NSMutableArray* actionCellModels;

@end

@implementation BaseTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    _actionCellModels = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 添加一个Cell和Cell对应的点击事件回调block
 @param actionName Cell显示名称
 @param callback 点击事件回调block
 */
- (void)addActionWithName:(NSString *)actionName callback:(void(^)(void))callback {
    ActionCellModel* model = [[ActionCellModel alloc] initWithActionName:actionName actionCallBack:^{
        !callback ?: callback();
    }];
    [_actionCellModels addObject:model];
}

/**
 添加一个Cell和Cell对应的点击跳转到的ViewController的class
 @param destViewControllClass 转到的ViewController的class
 */
- (void)addActionWithDestViewControllClass:(Class)destViewControllClass {
    [self addActionWithName:NSStringFromClass(destViewControllClass) destViewControllClass:destViewControllClass];
}

/**
 添加一个Cell和Cell对应的点击跳转到的ViewController的class
 @param detailText 描述文字
 @param destViewControllClass 转到的ViewController的class
 */
- (void)addActionWithDetailText:(NSString *)detailText destViewControllClass:(Class)destViewControllClass {
    [self addActionWithName:NSStringFromClass(destViewControllClass) detailText:detailText destViewControllClass:destViewControllClass];
}

/**
 添加一个Cell和Cell对应的点击跳转到的ViewController的class
 @param name Cell显示名称
 @param destViewControllClass 转到的ViewController的class
 */
- (void)addActionWithName:(NSString *)name destViewControllClass:(Class)destViewControllClass {
    [self addActionWithName:name detailText:nil destViewControllClass:destViewControllClass];
}

- (void)addActionWithName:(NSString *)name detailText:(NSString *)detailText destViewControllClass:(Class)destViewControllClass {
    ActionCellModel* model = [[ActionCellModel alloc] initWithActionName:name actionCallBack:^{
        UIViewController* vc = [[destViewControllClass alloc] init];
        vc.title = name;
        if ([vc isKindOfClass:[UIViewController class]]) {
            [UIUtil pushViewController:vc animated:YES];
        }
    }];
    model.detailText = detailText;
    [_actionCellModels addObject:model];
}

#pragma mark - ......::::::: UITableViewDelegate :::::::......

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _actionCellModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    ActionCellModel* model = _actionCellModels[indexPath.row];
    cell.textLabel.text = model.actionName;
    if (model.detailText) {
        cell.detailTextLabel.text = model.detailText;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActionCellModel* model = _actionCellModels[indexPath.row];
    !model.actionCallBack ?: model.actionCallBack();
}
@end
