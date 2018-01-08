//
//  TitleButton.m
//  News
//
//  Created by LinChanglong on 2018/1/8.
//  Copyright © 2018年 linchl. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0] forState:UIControlStateNormal];
        self.mask = [[UIView alloc] initWithFrame:self.bounds];
        self.mask.backgroundColor = [UIColor redColor];
        self.mask.hidden = YES;
        [self addSubview:self.mask];
    }
    return self;
}

@end
