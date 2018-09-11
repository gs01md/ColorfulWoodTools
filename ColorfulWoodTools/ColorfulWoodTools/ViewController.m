//
//  ViewController.m
//  ColorfulWoodTools
//
//  Created by 大新 on 2018/6/6.
//  Copyright © 2018年 ColorfulWood. All rights reserved.
//

#import "ViewController.h"
#import "ColorfulWoodMultiDelegate.h"
#import "ColorfulWoodPhoneCall.h"
#import "ColorfulWoodSelectPhoto.h"

@interface ViewController (){

    ColorfulWoodMultiDelegate * dele;
    NSObject * obj2;
}
- (IBAction)fssssss:(id)sender;

@end

@implementation ViewController

- (instancetype)init{

    if (self = [super init]) {

    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    {
    NSObject * obj = [NSObject new];
    dele = [ColorfulWoodMultiDelegate new];

    [dele interface_addDelegate:obj];
    [dele interface_addDelegate:obj];
    }

    obj2 = [NSObject new];
    [dele interface_addDelegate:obj2];
    [dele interface_addDelegate:obj2];

    NSLog(@"");

    //[ColorfulWoodPhoneCall interface_callPhone:@""];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)fssssss:(id)sender {

    [[[ColorfulWoodSelectPhoto alloc] initWithController:self] interface_show];

    [dele interface_compact];
    NSLog(@"");
}
@end
