//
//  UIImage+Group.m
//  ImageMore
//
//  Created by Eric on 15/6/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "UIImage+Group.h"
#import "UIImage+RoundedCorner.h"

static inline float radiansGroup(double degrees) { return degrees * M_PI / 180; }

@implementation UIImage (Group)

+ (UIImage *)imageRect:(CGSize)size image:(UIImage *)image frame:(CGRect)frame fillColor:(UIColor *)fillColor path:(UIBezierPath *)path{
    CGRect frameShow = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frameShow.size, NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (path) {
        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width*.5+frame.origin.x, frame.size.width*.5+frame.origin.y) radius:frame.size.width*.5 startAngle:0 endAngle:M_PI*2 clockwise:1];
        CGContextSaveGState(context);
        CGContextAddPath(context, path1.CGPath);
        CGContextClip(context);
    }
    
    
    image = [image roundedCornerImage:image.size.width*.5
                           borderSize:0];
    [image drawInRect:frame blendMode:kCGBlendModeNormal alpha:1.0];
    
    if (path) {
        CGContextAddPath(context, path.CGPath);
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillPath(context);
        
        CGContextAddPath(context, path.CGPath);
        CGContextSetBlendMode(context, kCGBlendModeClear);
        CGContextFillPath(context);
    }
    
    UIImage *imageEnd = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageEnd;
}


+ (UIImage *)creatGroupImage:(NSArray *)images
                   backColor:(UIColor *)bgColor
                        size:(CGSize)size
                        edge:(float)edge
                       scale:(float)scale {
    NSInteger count =  images.count;
    float length = MIN(size.width, size.height);
    CGSize aSize = CGSizeMake(length, length);
    
    if (count == 0) {
        return [UIImage groupImageBackColor:bgColor size:aSize];
    }
    if (count == 1) {
        return [UIImage groupImageOne:images backColor:bgColor size:aSize edge:edge scale:scale];
    }
    if (count == 2) {
        return [UIImage groupImageTwo:images backColor:bgColor size:aSize edge:edge scale:scale];
    }
    if (count == 3) {
        return [UIImage groupImageThree:images backColor:bgColor size:aSize edge:edge scale:scale];
    }
    if (count == 4) {
        return [UIImage groupImageFour:images backColor:bgColor size:aSize edge:edge scale:scale];
    }
    if (count >= 5) {
        return [UIImage groupImageFive:images backColor:bgColor size:aSize edge:edge scale:scale];
    }
    return [UIImage groupImageBackColor:bgColor size:aSize];
}

+ (UIImage *)groupImageFive:(NSArray *)images
                  backColor:(UIColor *)bgColor
                       size:(CGSize)size
                       edge:(float)edge
                      scale:(float)ascale
{
    CGRect frameShow = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frameShow.size, NO, [UIScreen mainScreen].scale);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: frameShow];
    [bgColor setFill];
    [rectanglePath fill];
    
    float scale = 0.4;
    if (ascale > 0 && ascale < 1) {
        scale = ascale;
    }
    if (edge <= 0) {
        edge = size.width*.03;
    }
    
    float length = size.width*scale;
    
    if (images.count >= 5) {
//        内切圆的半径
        float r0 = 0.5*(size.height-length)/(1+cos(36.0));
        float _angle = 72.0;
        
        CGPoint center0 = CGPointMake(size.width*.5, length*.5);
        CGPoint center1 = CGPointMake(size.width-length*.5, (r0+length*.5)-r0*cos(radiansGroup(_angle)));
        CGPoint center2 = CGPointMake(size.width*.5+r0*sin(radiansGroup(_angle*.5)), size.height-length*.5);
        CGPoint center3 = CGPointMake(size.width*.5-r0*sin(radiansGroup(_angle*.5)), size.height-length*.5);
        CGPoint center4 = CGPointMake(length*.5, (r0+length*.5)-r0*cos(radiansGroup(_angle)));
        
        
        for (int i = 0; i < 5; i++) {
            UIImage *image = images[i];
            CGRect frame = CGRectZero;
            
            if (i == 0) {
                frame = CGRectMake(center0.x-length*.5, center0.y-length*.5, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:center4 radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else if (i == 1 ){
                frame = CGRectMake(center1.x-length*.5, center1.y-length*.5, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:center0 radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else if (i == 2 ){
                frame = CGRectMake(center2.x-length*.5, center2.y-length*.5, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:center1 radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else if (i == 3 ){
                frame = CGRectMake(center3.x-length*.5, center3.y-length*.5, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:center2 radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else {
                frame = CGRectMake(center4.x-length*.5, center4.y-length*.5, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:center3 radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }
            
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)groupImageFour:(NSArray *)images
                  backColor:(UIColor *)bgColor
                       size:(CGSize)size
                       edge:(float)edge
                      scale:(float)ascale
{
    CGRect frameShow = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frameShow.size, NO, [UIScreen mainScreen].scale);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: frameShow];
    [bgColor setFill];
    [rectanglePath fill];
    
    float scale = 0.55;
    if (ascale > 0 && ascale < 1) {
        scale = ascale;
    }
    if (edge <= 0) {
        edge = size.width*.03;
    }
    
    float length = size.width*scale;
    
    if (images.count >= 4) {
        for (int i = 0; i < 4; i++) {
            UIImage *image = images[i];
            CGRect frame = CGRectZero;
            
            if (i == 0) {
                frame = CGRectMake(0, 0, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:CGPointMake(length*.5, size.height-length*.5) radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else if (i == 1 ){
                frame = CGRectMake(size.width-length, 0, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:CGPointMake(length*.5, length*.5) radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else if (i == 2 ){
                frame = CGRectMake(size.width-length, size.height-length, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:CGPointMake(size.width-length*.5, length*.5) radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else {
                frame = CGRectMake(0, size.height-length, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:CGPointMake(size.width-length*.5, size.height-length*.5) radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }
            
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)groupImageThree:(NSArray *)images
                   backColor:(UIColor *)bgColor
                        size:(CGSize)size
                        edge:(float)edge
                       scale:(float)ascale
{
    CGRect frameShow = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frameShow.size, NO, [UIScreen mainScreen].scale);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: frameShow];
    [bgColor setFill];
    [rectanglePath fill];
    
    float scale = 0.6;
    if (ascale > 0 && ascale < 1) {
        scale = ascale;
    }
    if (edge <= 0) {
        edge = size.width*.03;
    }
    float length = size.width*scale;
    
    if (images.count >= 3) {
        for (int i = 0; i < 3; i++) {
            UIImage *image = images[i];
            CGRect frame = CGRectZero;
            
            if (i == 0) {
                frame = CGRectMake(size.width*.5-length*.5, 0, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:CGPointMake(length*.5, size.height-length*.5) radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else if (i == 1 ){
                frame = CGRectMake(size.width-length, size.height-length, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:CGPointMake(size.width*.5, length*.5) radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else {
                frame = CGRectMake(0, size.height-length, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:CGPointMake(size.width-length*.5, size.width-length*.5) radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];
                
                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }
            
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)groupImageTwo:(NSArray *)images
                 backColor:(UIColor *)bgColor
                      size:(CGSize)size
                      edge:(float)edge
                     scale:(float)ascale
{
    CGRect frameShow = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frameShow.size, NO, [UIScreen mainScreen].scale);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: frameShow];
    [bgColor setFill];
    [rectanglePath fill];
    
    if (images.count >= 2) {
        float scale = 0.65;
        if (ascale > 0 && ascale < 1) {
            scale = ascale;
        }
        if (edge <= 0) {
            edge = size.width*.03;
        }
        float length = size.width*scale;
        
        for (int i = 0; i < 2; i++) {
            UIImage *image = images[i];
            CGRect frame = CGRectZero;
            
            if (i == 0) {
                frame = CGRectMake(0, 0, length, length);
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path addArcWithCenter:CGPointMake(size.width-length*.5, size.height-length*.5) radius:length*.5+edge startAngle:0 endAngle:M_PI*2 clockwise:1];

                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:path];
                [image drawInRect:frameShow];
            }else {
                frame = CGRectMake(size.width-length, size.width-length, length, length);

                image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:nil];
                [image drawInRect:frameShow];
            }
            
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)groupImageOne:(NSArray *)images
                 backColor:(UIColor *)bgColor
                      size:(CGSize)size
                      edge:(float)edge
                     scale:(float)ascale
{
    CGRect frameShow = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frameShow.size, NO, [UIScreen mainScreen].scale);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: frameShow];
    [bgColor setFill];
    [rectanglePath fill];
    
    if (images.count >= 1) {
        float scale = 1;
        if (ascale > 0 && ascale < 1) {
            scale = ascale;
        }
        float length = size.width*scale;
        UIImage *image = [images firstObject];
        CGRect frame = CGRectMake(0, 0, length, length);
        image = [UIImage imageRect:size image:image frame:frame fillColor:bgColor path:nil];
        [image drawInRect:frameShow];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)groupImageBackColor:(UIColor *)bgColor
                       size:(CGSize)size
{
    CGRect frameShow = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frameShow.size, NO, [UIScreen mainScreen].scale);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: frameShow];
    [bgColor setFill];
    [rectanglePath fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
