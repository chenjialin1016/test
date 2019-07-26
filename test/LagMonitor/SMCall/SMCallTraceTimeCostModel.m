//
//  SMCallTraceTimeCostModel.m
//  test
//
//  Created by Jialin Chen on 2019/7/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import "SMCallTraceTimeCostModel.h"

@implementation SMCallTraceTimeCostModel

- (NSString *)des{
    
    NSMutableString *str = [NSMutableString new];
    [str appendFormat:@"%2d| ",(int)_callDepth];
    [str appendFormat:@"%6.2f|",_timeCost * 1000.0];
    for (NSUInteger i = 0; i<_callDepth; i++) {
        [str appendString:@" "];
    }
    [str appendFormat:@"%s[%@ %@]",(_isClassMethod ? "+" : "-"),_className,_methodName];
    return str;
}

@end
