//
//  BatteryMonitor.m
//  test
//
//  Created by Jialin Chen on 2019/7/25.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import "BatteryMonitor.h"
#import "IOPSKeys.h"
#import "IOPowerSources.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation BatteryMonitor

/*
 找到Mac下IOKit.framework，将IOKit.framework里面的IOPowerSources.h和IOPSKeys.h拷贝到你的iOS项目中。另外, 还需要把IOKit也导入到你的工程中去，此方法也会出现偏差，不精确。
 */
- (double)getBatteryLevel{
    //返回电量信息
    CFTypeRef blob = IOPSCopyPowerSourcesInfo();
    //返回电量句柄列表数据
    CFArrayRef sources = IOPSCopyPowerSourcesList(blob);
    CFDictionaryRef pSource = NULL;
    const void *psValue;
    //返回数组大小
    int numOfSources = CFArrayGetCount(sources);
    //计算大小出错处理
    if (numOfSources == 0) {
        NSLog(@"Error in CFArrayGetCount");
        return  -1.0f;
    }
    
    //计算所剩电量
    for (int i = 0; i < numOfSources; i++) {
        //返回电源可读信息的字典
        pSource = IOPSGetPowerSourceDescription(blob, CFArrayGetValueAtIndex(sources, i));
        if (!pSource) {
            NSLog(@"Error in IOPSGetPowerSourceDescription");
            return -1.0f;
        }
        psValue = (CFStringRef)CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));
        
        int curCapacity = 0;
        int maxCapacity = 0;
        double percentage;
        
        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);
        
        psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
        CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);
        
        percentage = ((double)curCapacity/(double)maxCapacity * 100.0f);
        NSLog(@"curCapacity : %d / maxCapacity : %d, percentage: %.1f", curCapacity, maxCapacity, percentage);
        return percentage;
        
    }
    return -1;
}

/*
 通过苹果给的api获取
 */
- (double)getBatteryLevel2{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    return deviceLevel;
}
//另一种写法
- (double)getBatteryLevel3{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    static double deviceLevel;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceBatteryLevelDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        /*
         报错：Variable is not assignable (missing __block type specifier)
         解决：只需在变量声明时加上static关键字就可以了
         */
        deviceLevel = [UIDevice currentDevice].batteryLevel;
        NSLog(@"电池电量：%.2f", [UIDevice currentDevice].batteryLevel);
    }];
    return -1;
}


/*
 通过runtime 获取StatusBar上电池电量控件类私有变量的值，此方法可精准获取iOS6以上电池电量
 */
- (double)getBatteryLevel4{
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive || app.applicationState == UIApplicationStateInactive) {
        Ivar ivar = class_getInstanceVariable([app self], "_statusBar");
        id status = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame && [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
                    Ivar ivar = class_getInstanceVariable([bview class], "_capacity");
                    if (ivar) {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        //这种方式也可以
                        /*
                        ptrdiff_t offset = ivar_getOffset(ivar);
                        unsigned char *stuffBytes = (unsigned char *)(__bridge void *)bview;
                        batteryLevel = *((int *)(stuffBytes + offset));
                        */
                        NSLog(@"电池电量：%d",batteryLevel);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                        }else{
                            return 0;
                        }
                    }
                }
            }
        }
    }
    return 0;
}
@end
