//
//  Algorithm.swift
//  test
//
//  Created by Jialin Chen on 2019/5/24.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import Foundation

class Algorithm{
    //最接近的三数之和
    class func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        //将数组排序
        let nums = nums.sorted()
        let len = nums.count
        var res = nums[0]+nums[1]+nums[len-1]
        for i in 0..<len-2 {
            
            if i>0 && nums[i]==nums[i-1]{
                continue
            }
            
            //双指针遍历剩下的两位数
            var left = i+1
            var right = len-1
            
            while left < right{
                let tmp = nums[i]+nums[left]+nums[right]
                if tmp == target {
                    return target
                }
                //比较两数之差的绝对值大小，绝对值小的更接近目标值
                if abs(res-target) > abs(tmp-target){
                    res = tmp
                }
                if tmp>target {
                    right -= 1
                }
                if tmp<target{
                    left += 1
                }
            }
            
        }
        return res
    }
    
    
    //有效的括号
    class func isValid(_ s: String) -> Bool {
        if s.count == 0{
            return true
        }
        
        var arr : [Character] = []
        //遍历字符串
        for i in s {
            //判断字符是否是右括号，若是则判断栈顶元素是否是同一类型的左括号
            if i == ")" {
                if arr.popLast() != "("{
                    return false
                }
            }else if i == "]" {
                if arr.popLast() != "[" {
                    return false
                }
            }else if i == "}" {
                if arr.popLast() != "{" {
                    return false
                }
            }else{
                //不是右括号则入栈
                arr.append(i)
            }
        }
        //栈中元素为0则有效，反之无效
        return arr.count == 0
    }
}
