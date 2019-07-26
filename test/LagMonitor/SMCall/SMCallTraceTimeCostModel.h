//
//  SMCallTraceTimeCostModel.h
//  test
//
//  Created by Jialin Chen on 2019/7/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMCallTraceTimeCostModel : NSObject

@property (nonatomic, strong) NSString *className;      //类名
@property (nonatomic, strong) NSString *methodName;     //方法名
@property (nonatomic, assign) BOOL isClassMethod;       //是否是类方法
@property (nonatomic, assign) NSTimeInterval timeCost;  //时间消耗
@property (nonatomic, assign) NSUInteger callDepth;     //call 层级
@property (nonatomic, copy) NSString *path;             //  路径
@property (nonatomic, assign)BOOL lastCall;             //是否是最后一个call
@property (nonatomic, assign) NSUInteger frequency;     //访问频次
@property (nonatomic, strong)NSArray <SMCallTraceTimeCostModel*> *subCosts;

- (NSString *)des;

@end

NS_ASSUME_NONNULL_END
