//
//  ColorfulWoodSelectPhoto.h
//  ColorfulWoodTools
//
//  Created by 大新 on 2017/3/21.
//  Copyright © 2017年 ColorfulWood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ColorfulWoodSelectPhotoDelegate <NSObject>

/**
 * 选择好图片
 */
- (void)ColorfulWoodSelectPhotoDelegate_success:(UIImage*)img;

// 后续操作，保存图片至本地
//        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);//UIImagePNGRepresentation(image);
//
//        NSString *imageBase64 = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];

//NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:imageBase64,@"Avatar", nil],@"User", nil];

//[self.m_viewController updateUserInfoWithDic:dic];

@end

@interface ColorfulWoodSelectPhoto : NSObject

@property(nonatomic, weak) id<ColorfulWoodSelectPhotoDelegate> delegate;




@end
