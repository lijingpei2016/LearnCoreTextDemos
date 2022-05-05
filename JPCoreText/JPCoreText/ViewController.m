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

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) JPReaderChapterModel *currentChapterModel;

@property (nonatomic, assign) NSInteger currentChapterIndex;

@property (nonatomic, assign) NSInteger currentPageIndex;


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
    self.currentPageIndex = 0;
    self.currentChapterIndex = 0;

    NSDictionary *bookDict = [NSDictionary
                              dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                            pathForResource:@"bookData"
                                                                     ofType:@"plist"]];
    NSArray *dataArr = [bookDict valueForKey:@"data2"];

    for (NSDictionary *tempDict in dataArr) {
        
        //内容
        NSString *context = tempDict[@"context"];
        NSData *sData = [[NSData alloc]initWithBase64EncodedString:context options:NSDataBase64DecodingIgnoreUnknownCharacters];
        NSString *dataString = [[NSString alloc]initWithData:sData encoding:NSUTF8StringEncoding];
        
        //标题
        NSString *name = tempDict[@"name"];

        JPReaderChapterModel *contextModel = [[JPReaderChapterModel alloc] init];
        contextModel.chapterName = name;
        JPReaderItemModel *itemModel = [[JPReaderItemModel alloc] init];
        itemModel.type = JPReaderItemModelTypeText;
        itemModel.text = dataString;
        [contextModel addItem:itemModel];
        
        [self.dataArr addObject:contextModel];
        
        if (_currentChapterModel == nil) {
            _currentChapterModel = contextModel;
        }
    }

    
}

- (void)setupUI {
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    JPReaderPageViewController *firVC = [self viewControllerAtIndex:self.currentPageIndex];
    NSArray *viewControllers = [NSArray arrayWithObject:firVC];
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:nil];
}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate

#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (self.currentPageIndex == 0) {
        
        if (self.currentChapterIndex == 0) {
            return nil;
        }
        
        self.currentChapterIndex --;
        self.currentChapterModel = self.dataArr[self.currentChapterIndex];
        self.currentPageIndex = self.currentChapterModel.locationArr.count -2;
        return [self viewControllerAtIndex:self.currentPageIndex];

    }
    self.currentPageIndex--;
    return [self viewControllerAtIndex:self.currentPageIndex];
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (self.currentPageIndex >= self.currentChapterModel.locationArr.count - 2) {
        self.currentPageIndex = 0;
        self.currentChapterIndex ++;
        if (self.currentChapterIndex < self.dataArr.count) {
            self.currentChapterModel = self.dataArr[self.currentChapterIndex];
            return [self viewControllerAtIndex:self.currentPageIndex];
        }else {
            return nil;
        }
    }
    self.currentPageIndex++;
    return [self viewControllerAtIndex:self.currentPageIndex];
}

#pragma mark ========================= 私有方法 =========================

- (JPReaderPageViewController *)viewControllerAtIndex:(NSUInteger)index {
    JPReaderPageViewController *vc = [[JPReaderPageViewController alloc] init];
    vc.contextModel = self.currentChapterModel;
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

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
