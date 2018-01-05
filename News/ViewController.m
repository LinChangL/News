//
//  ViewController.m
//  News
//
//  Created by LinChanglong on 2018/1/5.
//  Copyright © 2018年 linchl. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "RecommendTableViewController.h"
#import "VideoTableViewController.h"
#import "HotTableViewController.h"
#import "RecreationTableViewController.h"

#define titleHeight   44
#define titleWidth    150
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configViews];
    [self createSubControllers];
    [self setupAllTitle];
}

- (UIScrollView *)titleScrollView {
    if (_titleScrollView == NULL) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_titleScrollView];
    }
    return _titleScrollView;
}

- (UIScrollView *)mainScrollView {
    if (_mainScrollView == NULL) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.backgroundColor = [UIColor yellowColor];
        _mainScrollView.bounces = YES;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}

- (NSMutableArray *)titleButtons {
    if (_titleButtons == NULL) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)configViews {
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(0);
        }
        make.height.mas_equalTo(titleHeight);
    }];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleScrollView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)createSubControllers {
    RecommendTableViewController *recommendVC = [[RecommendTableViewController alloc] init];
    recommendVC.title = @"推荐";
    [self addChildViewController:recommendVC];
    
    VideoTableViewController *videoVC = [[VideoTableViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    HotTableViewController *hotVC = [[HotTableViewController alloc] init];
    hotVC.title = @"热点";
    [self addChildViewController:hotVC];
    
    RecreationTableViewController *recreationVC = [[RecreationTableViewController alloc] init];
    recreationVC.title = @"娱乐";
    [self addChildViewController:recreationVC];
}

- (void)setupAllTitle {
    [self.childViewControllers enumerateObjectsUsingBlock:^(UITableViewController *  _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = idx;
        button.frame = CGRectMake(idx * titleWidth, 0, titleWidth, titleHeight);
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectController:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleButtons addObject:button];
        [_titleScrollView addSubview:button];
        
        if (idx == 0) {
            [self selectController:button];
        }
    }];
    
    self.titleScrollView.contentSize = CGSizeMake(self.childViewControllers.count * titleWidth, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    self.mainScrollView.contentSize = CGSizeMake(self.childViewControllers.count * SCREEN_WIDTH, 0);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)selectController:(UIButton *)button {
    [self.selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self setTitlePosWithButtonIndex:button.tag];
    UITableViewController *vc = self.childViewControllers[button.tag];
    [self.mainScrollView addSubview:vc.view];
    CGFloat left = button.tag * SCREEN_WIDTH;
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mainScrollView);
        make.height.equalTo(self.mainScrollView);
        make.left.mas_equalTo(left);
        make.top.mas_equalTo(0);
    }];
    self.mainScrollView.contentOffset = CGPointMake(left, 0);
    self.selectButton = button;
}

- (void)setTitlePosWithButtonIndex:(NSInteger)index {
    CGFloat buttonLeft = index * titleWidth;
    CGFloat buttonRight = buttonLeft + titleWidth;
    if (buttonLeft - self.titleScrollView.contentOffset.x < 0) {
        [self.titleScrollView setContentOffset:CGPointMake(buttonLeft, 0) animated:YES];
    } else if (buttonRight - self.titleScrollView.contentOffset.x > SCREEN_WIDTH) {
        [self.titleScrollView setContentOffset:CGPointMake(buttonRight - SCREEN_WIDTH, 0) animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger idx = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self selectController:self.titleButtons[idx]];
}


@end
