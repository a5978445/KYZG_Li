//
//  UIDevice+SystemInfo.h
//  iosapp
//
//  Created by Graphic-one on 16/8/4.
//  Copyright © 2016年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DeviceResolution){
    Device_iPhone_4 = 0 ,
    Device_iPhone_4s    ,
    Device_iPhone_5     ,
    Device_iPhone_5c    ,
    Device_iPhone_5s    ,
    Device_iPhone_6     ,
    Device_iPhone_6p    ,
    Device_iPhone_6s    ,
    Device_iPhone_6sp   ,
    Device_iPhone_se    ,
    Device_Simulator
};

typedef NS_ENUM(NSUInteger,SystemVersion){
    Version_iOS7 = 0    ,
    Version_iOS8        ,
    Version_iOS9        ,
    Version_iOS10       ,
    Version_noSupport
};

@interface UIDevice (SystemInfo)

+ (DeviceResolution) currentDeviceResolution;

+ (SystemVersion) currentSystemVersion;

@end
