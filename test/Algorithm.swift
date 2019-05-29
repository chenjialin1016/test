//
//  Algorithm.swift
//  test
//
//  Created by Jialin Chen on 2019/5/24.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import Foundation

class Algorithm{
    //MARK:-----------最接近的三数之和
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
    
    
    //MARK:-----------有效的括号
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
    
    //MARK:-----------合并两个有序链表
    class func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        //创建新链表节点
        var result = ListNode.init(0)
        //p代表新链表的头节点
        var p = result
        var l1 = l1
        var l2 = l2
        
        //遍历两个链表
        while (l1 != nil) && (l2 != nil) {
            //如果l1的值比l2的值小，则将l1节点加入新链表，并更新l1的节点，反之则将l2加入新链表，更新l2的节点
            if l1!.val < l2!.val {
                result.next = l1
                l1 = l1?.next
            }else{
                result.next = l2
                l2 = l2?.next
            }
            result = result.next!
        }
        //如果l1先比l2遍历完，则l2剩余的节点直接加入新链表，反之一样
        if l1 == nil {
            result.next = l2
        }else{
            result.next = l1
        }
        
        return p.next
    }
    //递归合并
    class func mergeTwoLists1(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        //1、新建链表递归
//        guard let l1 = l1 else{
//            return l2
//        }
//        guard let l2 = l2 else{
//            return l1
//        }
//        var result : ListNode? = (l1.val < l2.val) ? l1 : l2
//        if l1.val < l2.val {
//            result?.next = mergeTwoLists1(l1.next, l2)
//        }else{
//            result?.next = mergeTwoLists1(l1, l2.next)
//        }
//
//        return result
        
        //原链表递归
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        //每次取出两个链表中中最小的值给head
        if l1!.val < l2!.val {
            l1?.next = mergeTwoLists1(l1!.next, l2)
            return l1
        }else{
            l2?.next = mergeTwoLists1(l1, l2!.next)
            return l2
        }
        
        

    }
    
    //MARK:-----------合并k个排序链表
    class func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var lists = lists
        if lists.count == 0 {
            return nil
        }
        var result : ListNode?
        //遍历数组
        for i in 0..<lists.count {
            for j in i+1..<lists.count{
                if lists[i]!.val < lists[j]!.val {
                    result = lists[i]
                    result?.next = mergeTwoLists1(lists[i]?.next, lists[j])
                }else{
                    result = lists[j]
                    result?.next = mergeTwoLists1(lists[i], lists[j]?.next)
                }
            }
        }
        
        return result
    }
    
    //MARK:-----------
    
    //MARK:-----------
}


//MARK:-----------链表节点定义
public class ListNode{
    public var val : Int
    public var next : ListNode?
    public init(_ val : Int){
        self.val = val
        self.next = nil
    }
}
