//
//  HXTagAttribute.m
//  HXTagsView https://github.com/huangxuan518/HXTagsView
//  博客地址 http://blog.libuqing.com/
//  Created by Love on 16/6/30.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXTagAttribute.h"

@implementation HXTagAttribute

- (instancetype)init
{
    self = [super init];
    if (self) {
//        int r = arc4random() % 255;
//        int g = arc4random() % 255;
//        int b = arc4random() % 255;
        
//        UIColor *normalColor = [UIColor colorWithRed:b/255.0 green:r/255.0 blue:g/255.0 alpha:1.0];
        UIColor *normalBackgroundColor = [UIColor whiteColor];
//        UIColor *selectedBackgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        
        _borderWidth = 0.5f;
        _borderColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:0.6];
        _cornerRadius = 3.0;
        _normalBackgroundColor = normalBackgroundColor;
        _selectedBackgroundColor = [UIColor colorWithRed:231/255.0 green:31/255.0 blue:25/255.0 alpha:1.0];
        _selectedTextColor = [UIColor whiteColor];
        _titleSize = 14;
        _textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _keyColor = [UIColor redColor];
        _tagSpace = 20;
    }
    return self;
}

@end
