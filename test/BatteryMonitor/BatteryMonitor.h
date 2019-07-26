//
//  BatteryMonitor.h
//  test
//
//  Created by Jialin Chen on 2019/7/25.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BatteryMonitor : NSObject

/*
 找到Mac下IOKit.framework，将IOKit.framework里面的IOPowerSources.h和IOPSKeys.h拷贝到你的iOS项目中。另外, 还需要把IOKit也导入到你的工程中去，此方法也会出现偏差，不精确。
 */
- (double)getBatteryLevel;

/*
 通过苹果给的api获取
 */
- (double)getBatteryLevel2;
- (double)getBatteryLevel3;

/*
 通过runtime 获取StatusBar上电池电量控件类私有变量的值，此方法可精准获取iOS6以上电池电量
 */
- (double)getBatteryLevel4;
@end

NS_ASSUME_NONNULL_END
