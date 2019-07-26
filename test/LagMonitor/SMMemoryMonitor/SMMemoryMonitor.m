//
//  SMMemoryMonitor.m
//  test
//
//  Created by Jialin Chen on 2019/7/22.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import "SMMemoryMonitor.h"
#import "SMCallStack.h"

@implementation SMMemoryMonitor
//内存使用量的监控
+ (uint64_t)memoryUsage{
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t result = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&vmInfo, &count);
    if (result != KERN_SUCCESS) {
        return 0;
    }
    return vmInfo.phys_footprint;
}
@end
