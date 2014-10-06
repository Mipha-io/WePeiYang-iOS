//
//  wpyDeviceStatus.h
//  WePeiYang
//
//  Created by Qin Yubo on 14-4-3.
//  Copyright (c) 2014年 Qin Yubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wpyDeviceStatus : NSObject

+ (NSString *)getAppVersion;
+ (NSString *)getDeviceModel;
+ (NSString *)getDeviceOSVersion;
+ (NSString *)getScreenSize;

@end
