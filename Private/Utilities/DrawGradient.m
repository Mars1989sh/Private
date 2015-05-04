//
//  DrawGradient.m
//  Private
//
//  Created by Mars on 15/1/14.
//  Copyright (c) 2015年 MarsZhang. All rights reserved.
//

#import "DrawGradient.h"




@implementation DrawGradient
+(UIColor*)DrawGradientWithIndex:(int)index
{
    UIImage *uiImage;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%f key",keyWindow.frame.size.width);
    //===========================
    
    if (index==1) {
        CGFloat colors[] = {
            188.0 / 255.0, 243.0 / 255.0, 255.0 / 255.0, 1.00,
            6.0 / 255.0, 120.0 / 255.0, 238.0 / 255.0, 1.00,
        };
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGGradientRef myGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
        CGContextRef bitmapContext = CGBitmapContextCreate(NULL, 320, keyWindow.frame.size.height, 8, 4 * 320, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
        CGContextDrawLinearGradient(bitmapContext, myGradient, CGPointMake(160.0f, 0.0f),CGPointMake(160.0f, keyWindow.frame.size.height),  kCGGradientDrawsBeforeStartLocation);
        CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
        uiImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        CGContextRelease(bitmapContext);
    }else if (index == 2){
        CGFloat colors[] = {
            149.0 / 255.0, 251.0 / 255.0, 255.0 / 255.0, 1.00,
            12.0 / 255.0, 172.0 / 255.0, 196.0 / 255.0, 1.00,
        };
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGGradientRef myGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
        CGContextRef bitmapContext = CGBitmapContextCreate(NULL, 320, keyWindow.frame.size.height, 8, 4 * 320, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
        CGContextDrawLinearGradient(bitmapContext, myGradient, CGPointMake(160.0f, 0.0f),CGPointMake(160.0f, keyWindow.frame.size.height),  kCGGradientDrawsBeforeStartLocation);
        CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
        uiImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        CGContextRelease(bitmapContext);
    }else if (index == 3){
        CGFloat colors[] = {
            170.0 / 255.0, 240.0 / 255.0, 153.0 / 255.0, 1.00,
            57.0 / 255.0, 198.0 / 255.0, 47.0 / 255.0, 1.00,
        };
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGGradientRef myGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
        CGContextRef bitmapContext = CGBitmapContextCreate(NULL, 320, keyWindow.frame.size.height, 8, 4 * 320, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
        CGContextDrawLinearGradient(bitmapContext, myGradient, CGPointMake(160.0f, 0.0f),CGPointMake(160.0f, keyWindow.frame.size.height),  kCGGradientDrawsBeforeStartLocation);
        CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
        uiImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        CGContextRelease(bitmapContext);
    }else if (index == 4){
        CGFloat colors[] = {
            254.0 / 255.0, 221.0 / 255.0, 168.0 / 255.0, 1.00,
            246.0 / 255.0, 99.0 / 255.0, 47.0 / 255.0, 1.00,
        };
        
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGGradientRef myGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
        CGContextRef bitmapContext = CGBitmapContextCreate(NULL, 320, keyWindow.frame.size.height, 8, 4 * 320, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
        CGContextDrawLinearGradient(bitmapContext, myGradient, CGPointMake(160.0f, 0.0f),CGPointMake(160.0f, keyWindow.frame.size.height),  kCGGradientDrawsBeforeStartLocation);
        CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
        uiImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        CGContextRelease(bitmapContext);
    }
    


    return  [UIColor colorWithPatternImage:uiImage];
}
@end
