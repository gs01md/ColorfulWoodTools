//
//  ViewController.m
//  TestUI
//
//  Created by 大新 on 2017/1/28.
//  Copyright © 2017年 ColorWood. All rights reserved.
//

#import "ViewController.h"
#import <ColorfulWoodTools/ColorfulWoodTools.h>
#import <ColorfulWoodTools/ColorfulWoodImageBrowser.h>

@interface ViewController ()<
ColorfulWoodSelectPhotoDelegate
>{

}

@property(nonatomic, strong) ColorfulWoodSelectPhoto *m_photo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    //self.m_photo = [[ColorfulWoodSelectPhoto alloc] initWithController:self];
    [self performSelector:@selector(test) withObject:nil afterDelay:0.1];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];



}

- (void)test{

    //[self.m_photo interface_show];

    //[ColorfulWoodAlert showAlertAutoHideWithTitle:@"sssss" afterDelay:2.];

    ColorfulWoodImageBrowser * vc = [[ColorfulWoodImageBrowser alloc] init];
    [vc.m_imageArray addObject:@"http://images.fangshiliu.com/fsl-api2/king/2018-11-23/J51097aea-3eb7-499f-998b-eaeff4643a81.jpg"];
    [vc.m_imageArray addObject:@"http://images.fangshiliu.com/testup/2018-11-22/P45b58172-5497-402e-b40a-d8024c9c21da.jpg"];
    vc.m_imageArray = vc.m_imageArray;
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 * 选择好图片
 */
- (void)ColorfulWoodSelectPhotoDelegate_success:(UIImage*)img{
    
    NSLog(@"1111");
}


@end
