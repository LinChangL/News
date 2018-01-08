//
//  TitleButton.h
//  News
//
//  Created by LinChanglong on 2018/1/8.
//  Copyright © 2018年 linchl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleButton : UIButton

@property (nonatomic, strong) UIView *mask; // 用于实现滚动时字体颜色渐变效果

- (instancetype)initWithFrame:(CGRect)frame;

@end
