//
//  SMLagDB.h
//  test
//
//  Created by Jialin Chen on 2019/7/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB/FMDB.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "SMCallTraceTimeCostModel.h"

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

NS_ASSUME_NONNULL_BEGIN

@interface SMLagDB : NSObject

+ (SMLagDB *)shareInstance;

//-----------卡顿和cpu超标准线
- (RACSignal *)increaseWithStackString:(NSString *)str;
- (RACSignal *)selectStackWithPage:(NSUInteger)page;
- (void)clearStackData;

//-----------clscall方法调用频次
//添加记录
- (RACSignal *)increaseWithClsCallModel:(SMCallTraceTimeCostModel *)model;
//分页查询
- (RACSignal *)selectClsCallWithPage:(NSUInteger)page;
//清除数据
- (void)clearClsCallData;

@end

NS_ASSUME_NONNULL_END
