//
//  Algorithm.swift
//  test
//
//  Created by  on 2019/5/24.
//  Copyright © 2019年 . All rights reserved.
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
    //逐一比较
    //往一个数组里面放，排个序。再转换成链表
    class func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var lists = lists
        var result : [Int] = []
        
        //遍历链表数组，将每个链表的val直接加入数组中
        for i in lists {
            var item = i
            while item != nil {
                result.append((item?.val)!)
                item = item?.next
            }
        }
        if result.count == 0 {
            return nil
        }
        //链表val值的数组排序
        result = result.sorted()
        //将排好序的数组重新合成一个链表
        var head = ListNode(0)
        var p = head
        
        for i in result {
            p.next = ListNode(i)
            p = p.next!
        }
        return head.next
    }
    //递归：利用两个链表的合并方式递归
    //O(MlogL)其中M为链表数组中最长的链表的长度。
    //mergeKLists2的时间开销就是二分法得到的Log(L)
    class func mergeKLists2(_ lists: [ListNode?]) -> ListNode? {
        var lists = lists
        
        switch lists.count {
        case 0:
            return nil
        case 1:
            return lists[0]
        case 2:
            return mergeTwoLists(lists[0], lists[1])
        default:
            let mid = lists.count/2
            return mergeTwoLists(mergeKLists2(Array(lists[0...mid])), mergeKLists2(Array(lists[(mid+1)...(lists.count-1)])))
        }
    }
    
    //MARK:-----------删除排序数组中的重复项
    class func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        var current : Int = nums[0]
        //存储不同的数字
        var idx : [Int] = [current]
        //  遍历
        for i in 1..<nums.count {
            if current == nums[i] {
                continue
            }else{
                idx.append(nums[i])
                current = nums[i]
            }
        }
        nums = idx
        print(nums)
        return nums.count
    }
    //双指针法----定义一个快指针，一个慢指针
    class func removeDuplicates1(_ nums: inout [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        //慢指针，代表不同数组的下标
        var i = 0
        //j为快指针
        for j in 1..<nums.count {
            if nums[j] != nums[i] {
                i += 1
                nums[i] = nums[j]
            }
        }
        print(nums[0...i])
        return i+1
    }
    
    //MARK:-----------搜索旋转排序数组
    //时间复杂度O(logn)
    class func search(_ nums: [Int], _ target: Int) -> Int {
        //二分查找法：先找到数组中最小的数 即发生旋转的下标
        let n = nums.count
        if n==0 {
            return -1
        }
        if n==1 {
            return nums[0]==target ? 0 : -1
        }
        
        let rotate_index = Algorithm.find_rotate_index(nums, 0, n-1)
        
        //如果target是最小的值
        if nums[rotate_index] == target {
            return rotate_index
        }
        //如果数组并没有旋转，需要查找整个数组
        if rotate_index == 0 {
            return Algorithm.search(nums, target, 0, n-1)
        }
        if target < nums[0] {
            //如果目标值小于第一个数，在旋转下标的右边查找
            return search(nums, target, rotate_index, n-1)
        }else{
            return search(nums, target, 0, rotate_index)
        }
    }
    //找到旋转的下标
    private class func find_rotate_index(_ nums : [Int], _ left: Int, _ right : Int)->Int{
        var left = left
        var right = right
        if nums[left] < nums[right] {
            //数组未发生旋转
            return 0
        }
        
        //二分查找
        while left <= right {
            var pivot = (left+right)/2
            if nums[pivot] > nums[pivot+1] {
                //基准数>基准后一位，往右边查找
                return pivot+1
            }else{
                //如果基准数小于左边左边的数，则右下标左移一位，反之，左下标右移一位
                if nums[pivot]<nums[left]{
                    right = pivot-1
                }else{
                    left = pivot+1
                }
            }
        }
        return 0
    }
    //根据下标二分查找
    private class func search(_ nums : [Int], _ target : Int, _ left: Int, _ right : Int)->Int{
        var left = left
        var right = right
        
        while left <= right {
            var pivot = (left+right)/2
            if nums[pivot]==target {
                return pivot
            }else{
                if target < nums[pivot] {
                    right = pivot-1
                }else{
                    left = pivot+1
                }
            }
        }
        return -1
    }
    class func search1(_ nums: [Int], _ target: Int) -> Int {
        //二分查找法：先找到数组中最小的数 即分割点
        let n = nums.count
        if n==0 {
            return -1
        }
        var left = 0
        var right = n-1
        while left < right {
            let mid = left + (right-left)/2
            if nums[mid] > nums[right] {
                //如果中间的数大于右边的数，从mid的右边查找
                left = mid+1
            }else{
                right = mid
            }
        }
        //分割点下标
        let split_t = left
        left = 0
        right = n-1
        
        //判断分割点在target的左边还是右边
        if nums[split_t] <= target && target <= nums[right] {
            //分割点在target的右边
            left = split_t
        }else{
            //分割点在target的左边
            right = split_t
        }
        while left <= right {
            let mid = left + (right-left)/2
            if nums[mid] == target {
                //中间值等于目标值
                return mid
            }else if nums[mid] > target {
                //中间值大于目标值，右边下标左移一位
                right = mid - 1
            }else{
                //反之，左边下标右移一位
                left = mid+1
            }
        }
        return -1
    }
    class func search2(_ nums: [Int], _ target: Int) -> Int {
        //直接用二分法，判断二分点
        /*
         1、直接等于target
         2、在左半边递增区域
            1）target 在 left 和 mid 之间
            2）不在之间
         3、在右边的递增区域、
            1）target在mid 和 right 之间
            2）不在之间
         */
        let n = nums.count
        if n==0 {
            return -1
        }
        
        var left = 0
        var right = n-1
        while left < right {
            let mid = left+(right-left)/2
            if nums[mid] == target {
                return mid
            }else if nums[mid] >= nums[left]{//二分点在左半边递增区域
                if nums[left] <= target && target < nums[mid] {
                    //target位于 left 和 mid 之间
                    right = mid-1
                }else{
                    left = mid+1
                }
            }else if nums[mid] < nums[right]{
                //二分点在右边的递增区域
                if nums[mid] < target && target <= nums[right] {
                    left = mid+1
                }else{
                    right = mid-1
                }
            }
        }
//        print(left, right)
        return nums[left] == target ? left : -1
    }
    class func search3(_ nums: [Int], _ target: Int) -> Int {
        //直接用二分法，判断二分点-----超出时间限制
        let n = nums.count
        if n==0 {
            return -1
        }
        
        var left = 0
        var right = n-1
        while left <= right {
            let mid = left+(right-left)/2
            //如果中间值小于第一个数，目标值也小于第一个数，取中间值
            let num = (nums[mid]<nums[0]) == (target<nums[0]) ? nums[mid] : target<nums[0] ? Int.min : Int.max
            if num < target {
                //中间值小于目标值，在中间值的右边查找
                left = mid+1
            }else if num > target {
                //中间值大于目标值，在中间值的左边查找
                right = mid
            }else {
                //中间值等于目标值，返回中间值下标
                return mid
            }
        }
//        print(left, right)
        return -1
    }
    
    //MARK:-----------字符串相乘
    //模拟乘法,首先要进行字符串翻转,让低位在前面,方便处理进位
    class func multiply(_ num1: String, _ num2: String) -> String {
        
        if num1=="0" || num2=="0" {
            return "0"
        }
        
        var res : [Int] = [Int].init(repeating: 0, count: num1.count+num2.count)
        var num1Arr : [Character] = []
        var num2Arr : [Character] = []
        
        for i in num1{
            num1Arr.append(i)
        }
        for j in num2 {
            num2Arr.append(j)
        }
        //字符数组倒序存储
        num1Arr = num1Arr.reversed()
        num2Arr = num2Arr.reversed()

        print(num1Arr)
        print(num2Arr)

        //遍历数组
        for i in 0..<num1Arr.count {
            for j in 0..<num2Arr.count{
                //记录两两相乘的结果
                res[i+j] += Algorithm.stringToInt(String(num1Arr[i]))*Algorithm.stringToInt(String(num2Arr[j]))
            }
        }
        //进位值
        var carrys = 0
        //将两两相乘的结果遍历
        for i in 0..<res.count {
            res[i] += carrys
            carrys = res[i]/10
            res[i] %= 10
        }
        if carrys != 0 {
            res[res.count-1] = carrys
        }
        //结果值正序
        res = res.reversed()

        var str : String = ""
        var i = res[0]==0 ? 1 : 0
        for _ in i..<res.count {
            str += String(res[i])

            i += 1
        }

        return str
        
    }
    
    class func multiply2(_ num1: String, _ num2: String) -> String {
        
        if num1=="0" || num2=="0" {
            return "0"
        }
        
        var res : [Int] = [Int].init(repeating: 0, count: num1.count+num2.count)
        
        var num1Arr : [Int] = Algorithm.stringToArr(num1)
        var num2Arr : [Int] = Algorithm.stringToArr(num2)
        print(num1Arr)
        print(num2Arr)
        
        //遍历数组
        for i in 0..<num1Arr.count {
            for j in 0..<num2Arr.count{
                //记录两两相乘的结果
                res[i+j] += num1Arr[i]*num2Arr[j]
            }
        }
        //进位值
        var carrys = 0
        //将两两相乘的结果遍历
        for i in 0..<res.count {
            res[i] += carrys
            carrys = res[i]/10
            res[i] %= 10
        }
        if carrys != 0 {
            res[res.count-1] = carrys
        }
        //结果值正序
        res = res.reversed()
        
        var str : String = ""
        var i = res[0]==0 ? 1 : 0
        for _ in i..<res.count {
            str += String(res[i])
            
            i += 1
        }
        
        return str
        
    }
    
    //将字符串转换成数组并反转顺序
    private class func stringToArr(_ str : String)->[Int]{
        var result : [Int] = []
        for i in str{
            result.append(stringToInt(String(i)))
        }
        //字符数组倒序存储
        result = result.reversed()
        return result
    }
    
    //字符利用ascii转换为整数值
    private class func stringToInt(_ char : String)->Int{
        var result : Int = 0
        var result1 : Int = 0
        
        for characterInt in char.unicodeScalars {
            result = Int(characterInt.value)
        }
        for characterInt in "0".unicodeScalars {
            result1 = Int(characterInt.value)
        }
//        print(result-result1)
        return result-result1
    }
    
    //MARK:-----------全排列
    class func permute(_ nums: [Int]) -> [[Int]] {
        //回溯法
        /*
         是一种通过探索所有可能的候选解来找出所有的解的算法。如果候选解被确认 不是 一个解的话（或者至少不是 最后一个 解），回溯算法会通过在上一步进行一些变化抛弃该解，即 回溯 并且再次尝试。
         这里有一个回溯函数，使用第一个整数的索引作为参数 backtrack(first)。
         如果第一个整数有索引 n，意味着当前排列已完成。
         遍历索引 first 到索引 n - 1 的所有整数。Iterate over the integers from index first to index n - 1.
         在排列中放置第 i 个整数， 即 swap(nums[first], nums[i]).
         继续生成从第 i 个整数开始的所有排列: backtrack(first + 1).
         现在回溯，即通过 swap(nums[first], nums[i]) 还原.
         */
        var output : [[Int]] = []
        var num_list : [Int] = []
        for num in nums {
            num_list.append(num)
        }
        
        let n = nums.count
        backTrack(n, &num_list, &output, 0)
        return output
        
    }
    private class func backTrack(_ n : Int, _ nums : inout [Int], _ output : inout [[Int]], _ first : Int){
        //如果第一个索引为n 即当前排列已完成
        if first==n {
            //将生成的排列加入数组
            addArr(&output, nums)
        }
        
        for i in first..<n {
            //在排列中放置第i个整数
            nums.swapAt(first, i)
            //继续生成从第i个整数开始的所有排列
            backTrack(n, &nums, &output, first+1)
            //回溯，还原交换的数据
            nums.swapAt(first, i)
        }
    }
    //将生成的排列加入数组
    private class func addArr(_ output : inout [[Int]], _ nums : [Int]){
        output.append(nums)
    }
    
    //MARK:-----------
    
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
