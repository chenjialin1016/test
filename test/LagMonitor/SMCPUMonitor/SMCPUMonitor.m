//
//  SMCPUMonitor.m
//  test
//
//  Created by Jialin Chen on 2019/7/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import "SMCPUMonitor.h"
#import "SMCallStack.h"
#import "SMLagDB.h"

@implementation SMCPUMonitor

//轮询检查多个线程 cpu 情况
+ (void)updateCPU{
    thread_act_array_t threads;
    mach_msg_type_number_t threadCount = 0;
    const task_t thisTask = mach_task_self();
    kern_return_t kr = task_threads(thisTask, &threads, &threadCount);
    if (kr != KERN_SUCCESS) {
        return;
    }
    for (int i = 0; i < threadCount; i++) {
        thread_info_data_t threadInfo;
        thread_basic_info_t threadBaseInfo;
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        if (thread_info((thread_act_t)threads[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount) == KERN_SUCCESS) {
            threadBaseInfo = (thread_basic_info_t)threadInfo;
            if (!(threadBaseInfo->flags & TH_FLAGS_IDLE)) {
                integer_t cpuUsage = threadBaseInfo->cpu_usage / 10;
                if (cpuUsage > 70) {
                    //cup 消耗大于 70 时打印和记录堆栈
                    NSString *reStr = smStackOfThread(threads[i]);
                    //记录数据库中
                    [[[SMLagDB shareInstance] increaseWithStackString:reStr] subscribeNext:^(id x) {}];
                    NSLog(@"CPU useage overload thread stack：\n%@",reStr);
                }
            }
        }
    }
}

//获得当前app所在进程的cpu使用率
+ (integer_t)cpuUsage{
    //int组成的数组 比如 thread[1] = 5635
    thread_act_array_t threads;
    //mach_msg_type_number_t 是int类型
    mach_msg_type_number_t threadCount = 0;
    const task_t thisTask = mach_task_self();
    //根据当前task 获取所有线程
    kern_return_t kr = task_threads(thisTask, &threads, &threadCount);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    integer_t cpuUsage = 0;
    //遍历所有线程
    for (int i= 0; i<threadCount; i++) {
        thread_info_data_t threadInfo;
        thread_basic_info_t threadBaseInfo;
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        
        if (thread_info((thread_act_t)threads[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount)) {
            //获取cpu使用率
            threadBaseInfo = (thread_basic_info_t)threadInfo;
            if (!(threadBaseInfo->flags & TH_FLAGS_IDLE)) {
                cpuUsage += threadBaseInfo->cpu_usage;
            }
        }
    }
    assert(vm_deallocate(mach_task_self(), (vm_address_t)threads, threadCount*sizeof(thread_t)) == KERN_SUCCESS);
    return  cpuUsage;
}



@end
