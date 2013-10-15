//
//  UIImage+Aux.m
//  
//
//  Created by Marina Gray on 2013-04-04.
//  Copyright (c) 2013 Marina Gray. All rights reserved.
//

#import "UIImage+Aux.h"

@implementation UIImage (Aux)

- (UIColor *)getColorAtPoint:(CGPoint)p {
    // return the colour of the image at a specific point
    
    // make sure the point lies within the image
    if (p.x >= self.size.width || p.y >= self.size.height || p.x < 0 || p.y < 0) return nil;
        
    // First get the image into your data buffer
    CGImageRef imageRef = [self CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = [[UIScreen mainScreen] scale] * ((bytesPerRow * p.y) + p.x * bytesPerPixel);
    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
    
    free(rawData);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (CGSize)sizeThatFits:(CGSize)size{
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    
    // make sure the image is no greater than the viewable area
    if (w > size.width) {
        // scale the width to fit
        h = size.width * h / w;
        w = size.width;
    }
    
    if (h > size.height) {
        // scale the height to fit, if it still does not fit
        w = size.height * w / h;
        h = size.height;
    }
    return CGSizeMake(w, h);

}

@end
