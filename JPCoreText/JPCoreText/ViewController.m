//
//  ViewController.m
//  JPCoreText
//
//  Created by LJP on 2021/8/15.
//

#import "ViewController.h"
#import "JPReaderPageViewController.h"
#import "JPReaderView.h"

@interface ViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) JPReaderChapterModel *contextModel;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation ViewController

#pragma mark ========================= 生命周期 =========================

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupData];
    [self setupUI];
}

#pragma mark ========================= 初始化方法 ========================

- (void)setupData {
    self.currentIndex = 0;

    NSDictionary *bookDict = [NSDictionary
                              dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                            pathForResource:@"bookData"
                                                                     ofType:@"plist"]];
    NSArray *dataArr = [bookDict valueForKey:@"data"];

    JPReaderChapterModel *contextModel = [[JPReaderChapterModel alloc] init];

    for (NSString *temp in dataArr) {
        NSData *sData = [[NSData alloc]initWithBase64EncodedString:temp options:NSDataBase64DecodingIgnoreUnknownCharacters];
        NSString *dataString = [[NSString alloc]initWithData:sData encoding:NSUTF8StringEncoding];

        JPReaderItemModel *itemModel = [[JPReaderItemModel alloc] init];
        itemModel.type = JPReaderItemModelTypeText;
        itemModel.text = dataString;
        [contextModel addItem:itemModel];
    }

    self.contextModel = contextModel;
}

- (void)setupUI {
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    JPReaderPageViewController *firVC = [self viewControllerAtIndex:self.currentIndex];
    NSArray *viewControllers = [NSArray arrayWithObject:firVC];
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:nil];
}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate

#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.currentIndex == 0) {
        return nil;
    }
    self.currentIndex--;
    return [self viewControllerAtIndex:self.currentIndex];
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.currentIndex >= self.contextModel.locationArr.count - 2) {
        return nil;
    }
    self.currentIndex++;
    return [self viewControllerAtIndex:self.currentIndex];
}

#pragma mark ========================= 私有方法 =========================

- (JPReaderPageViewController *)viewControllerAtIndex:(NSUInteger)index {
    JPReaderPageViewController *vc = [[JPReaderPageViewController alloc] init];
    vc.contextModel = self.contextModel;
    vc.index = index;
    return vc;
}

#pragma mark ========================= 访问器方法 =========================

- (UIPageViewController *)pageViewController {
    if (_pageViewController == nil) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

@end
