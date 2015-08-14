//
//  UIImage+Group.h
//  ImageMore
//
//  Created by Eric on 15/6/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Group)

/**
 *  <#Description#>
 *
 *  @param images  <#images description#>
 *  @param bgColor 背景色
 *  @param size    大小  取正方形区域
 *  @param edge    2个图片的间隔大小  0 代码适应
 *  @param scale   圆形图片放大范围  <0 >1 代码适应
 *
 *  @return <#return value description#>
 */
+ (UIImage *)creatGroupImage:(NSArray *)images
                   backColor:(UIColor *)bgColor
                        size:(CGSize)size
                        edge:(float)edge
                       scale:(float)scale;


@end
