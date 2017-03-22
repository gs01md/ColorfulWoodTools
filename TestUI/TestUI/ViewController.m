//
//  ViewController.m
//  TestUI
//
//  Created by 大新 on 2017/1/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "ViewController.h"
#import <ColorfulWoodTools/ColorfulWoodTools.h>

@interface ViewController ()<
ColorfulWoodSelectPhotoDelegate
>{
    
    ColorfulWoodSelectPhoto * m_photo;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    m_photo = [[ColorfulWoodSelectPhoto alloc] initWithWithView:self];
}

/**
 * 选择好图片
 */
- (void)ColorfulWoodSelectPhotoDelegate_success:(UIImage*)img{
    
    NSLog(@"1111");
}


@end
