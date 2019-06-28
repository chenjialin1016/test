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
    
    //MARK:-----------最大子序和
    class func maxSubArray(_ nums: [Int]) -> Int {
        /*
         动态规划O(n)
         
         动态规划的是首先对数组进行遍历，当前最大连续子序列和为 sum，结果为 ans
         如果 sum > 0，则说明 sum 对结果有增益效果，则 sum 保留并加上当前遍历数字
         如果 sum <= 0，则说明 sum 对结果无增益效果，需要舍弃，则 sum 直接更新为当前遍历数字
         每次比较 sum 和 ans的大小，将最大值置为ans，遍历结束返回结果
         */
        var nums = nums
        var ans = nums[0]
        var sum : Int = 0
        for num in nums {
            if sum > 0{
                sum += num
            }else{
                sum = num
            }
            ans = max(ans, sum)
            
        }
        return ans
    }
    class func maxSubArray1(_ nums: [Int]) -> Int {
        /*
        暴力循环遍历 O(n^2)
         */
        var nums = nums
        //存最大值
        var maxValue = nums[0]
        var sum = 0
        
        for i in 0..<nums.count {
            sum = 0
            for j in i..<nums.count{
                sum += nums[j]
                if sum > maxValue{
                    maxValue = sum
                }
            }
        }
        return maxValue
    }
    class func maxSubArray2(_ nums: [Int]) -> Int {
        /*
         思路：
         1、定义一个max记录过程中最大值
         2、定义lSum、rSum从两头向中间推进的记录的两个最终子序和
         3、到中间汇聚，再取最大值：Math.max(max, lSum+rSum);
         */
        var nums = nums
        //过程中最大值
        var maxValue = max(nums[0], nums[nums.count-1])
        //左半部分，最近一次子序和
        var lSum = 0
        //右半部分，最近一次子序和
        var rSum = 0
        
        var i = 0, j = nums.count-1
        while i<=j {
            lSum = lSum>0 ? lSum+nums[i] : nums[i]
            maxValue = max(maxValue, lSum)
            
            if j != i {
                rSum = rSum>0 ? rSum+nums[j] : nums[j]
                maxValue = max(maxValue, rSum)
            }
            
            i += 1
            j -= 1
        }
        
        //汇聚
        //maxValue 左右两边最大的，lSum+rSum 中间聚合
        return max(maxValue, lSum+rSum)
    }
    class func maxSubArray3(_ nums: [Int]) -> Int {
        /*
         分治法思路：nlog(n)
         通过递归分治不断的缩小规模，问题结果就有三种，左边的解，右边的解，以及中间的解（有位置要求，从中介mid向两边延伸寻求最优解），得到三个解通过比较大小，等到最优解。
         */
        return maxSubArrayPart(nums, 0, nums.count-1)
    }
    private class func maxSubArrayPart(_ nums : [Int], _ left : Int, _ right : Int)->Int{
        if left == right {
            return nums[left]
        }
        
        let mid = (left+right)/2
        return max(maxSubArrayPart(nums, left, mid), max(maxSubArrayPart(nums, mid+1, right), maxSubArrayAll(nums, left, mid, right)))
    }
    //左右两边合起来求解
    private class func maxSubArrayAll(_ nums : [Int], _ left : Int, _ mid : Int, _ right : Int)->Int{
        var leftSum = -2147483648
        var sum = 0
        var i = mid
        while i >= left {
            sum += nums[i]
            if sum > leftSum {
                leftSum = sum
            }
            i -= 1
        }
        sum = 0
        var rightSum = -2147483648
        var j = mid+1
        while j<=right {
            sum += nums[j]
            if sum > rightSum{
                rightSum = sum
            }
            j += 1
        }
        
        return leftSum+rightSum
    }
    
    //MARK:-----------螺旋矩阵
    class func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        /*
         方法 1：模拟O(n)
         
         直觉
         
         绘制螺旋轨迹路径，我们发现当路径超出界限或者进入之前访问过的单元格时，会顺时针旋转方向。
         
         算法
         
         假设数组有R 行C 列，seen[r][c] 表示第 r 行第 c 列的单元格之前已经被访问过了。当前所在位置为(r, c)，前进方向是di。我们希望访问所有R xC 个单元格。
         
         当我们遍历整个矩阵，下一步候选移动位置是(cr, cc)。如果这个候选位置在矩阵范围内并且没有被访问过，那么它将会变成下一步移动的位置；否则，我们将前进方向顺时针旋转之后再计算下一步的移动位置。
         */
        var ans : [Int] = [Int]()
        if matrix.count == 0 {
            return ans
        }
        let R = matrix.count
        let C = matrix[0].count
        var seen : [[Bool]] = [[Bool]].init(repeating: [Bool].init(repeating: false, count: C), count: R)
        
        var dr = [0, 1, 0, -1]
        var dc = [1, 0, -1, 0]
        
        var r = 0, c = 0, di = 0
        
        for i in 0..<R*C {
            ans.append(matrix[r][c])
            seen[r][c] = true
            let cr = r + dr[di]
            let cc = c+dc[di]
            if 0<=cr && cr<R && 0<=cc && cc<C && !seen[cr][cc]{
                r = cr
                c = cc
            }else{
                di = (di+1)%4
                r += dr[di]
                c += dc[di]
            }
        }
        return ans
    }
    class func spiralOrder2(_ matrix: [[Int]]) -> [Int] {
        /*
         方法 2：按层模拟O(n)
         
         直觉
         
         答案是最外层所有元素按照顺时针顺序输出，其次是次外层，以此类推。
         
         算法
         
         我们定义矩阵的第 k 层是到最近边界距离为 k 的所有顶点。例如，下图矩阵最外层元素都是第 1 层，次外层元素都是第 2 层，然后是第 3 层的。
         对于每层，我们从左上方开始以顺时针的顺序遍历所有元素，假设当前层左上角坐标是(r1, c1)，右下角坐标是(r2, c2)。
         
         首先，遍历上方的所有元素(r1, c)，按照c = c1,...,c2 的顺序。然后遍历右侧的所有元素(r, c2)，按照r = r1+1,...,r2 的顺序。如果这一层有四条边（也就是r1 < r2 并且c1 < c2 ），我们以下图所示的方式遍历下方的元素和左侧的元素。
         
         */
        var ans : [Int] = [Int]()
        if matrix.count == 0 {
            return ans
        }
        var r1 = 0, r2 = matrix.count-1
        var c1 = 0, c2 = matrix[0].count-1
        
        while r1<=r2 && c1<=c2 {
            //第一行的数 top
            for c in c1...c2 {
                ans.append(matrix[r1][c])
            }
            //最右边除了第一行的所有最后一个数 right
            var r = r1+1
            while r <= r2 {
                ans.append(matrix[r][c2])
                r += 1
            }
            //下边及左边最外层数
            if r1<r2 && c1<c2 {
                //bottom
                var c = c2-1
                while c > c1 {
                    ans.append(matrix[r2][c])
                    c -= 1
                }
                //left
                var r = r2
                while r>r1{
                    ans.append(matrix[r][c1])
                    r -= 1
                }
            }
            r1 += 1
            r2 -= 1
            c1 += 1
            c2 -= 1
        }
        
        return ans
    }
    
    class func spiralOrder3(_ matrix: [[Int]]) -> [Int] {
        /*
         方法 3：从外部向内部逐层遍历打印矩阵，最外面一圈打印完，里面仍然是一个矩阵
         第i层矩阵的打印，需要经历4个循环
         从左到右
         从上倒下
         从右往左，如果这一层只有1行，那么第一个循环已经将该行打印了，这里就不需要打印了，即 （m-1-i ）!= i
         从下往上，如果这一层只有1列，那么第2个循环已经将该列打印了，这里不需要打印，即(n-1-i) != i
         */
        var ans : [Int] = [Int]()
        if matrix.count == 0 {
            return ans
        }
        let m = matrix.count
        let n = matrix[0].count
        var i = 0
        
        //统计矩阵从外向内的层数，如果矩阵为空，那么它的层数至少是1层
        let count = (min(m, n)+1)/2
        //从外部向内部遍历，逐层打印数据
        while i<count {
            //从左到右
            for j in i..<n-i {
                ans.append(matrix[i][j])
            }
            //从上到下
            for j in i+1..<m-i{
                ans.append(matrix[j][(n-1)-i])
            }
            
            //从右往左，如果这一层只有1行，那么第一个循环已经将该行打印了，这里就不需要打印了，即 （m-1-i ）!= i
            var j = (n-1)-(i+1)
            while j >= i && (m-1-i != i){
                ans.append(matrix[m-1-i][j])
                j -= 1
            }
            
            //从下往上，如果这一层只有1列，那么第2个循环已经将该列打印了，这里不需要打印，即(n-1-i) != i
            var k = (m-1)-(i+1)
            while k>=i+1 && (n-1-i != i){
                ans.append(matrix[k][i])
                k -= 1
            }
            
            i += 1
        }
        
        return ans
    }
    
    //MARK:-----------螺旋矩阵II
    class func generateMatrix(_ n: Int) -> [[Int]] {
        /*
         O(n^2)
         整体采用构建矩阵，填充矩阵的思路，填充过程分为四种情况：
         
         从左到右填充一行
         从上到下填充一列
         从右到左填充一行，注意只有一行的情况
         从下到上填充一列，注意只有一列的情况
         */
        
        //构建矩阵
        var matrix : [[Int]] = [[Int]].init(repeating: [Int].init(repeating: 0, count: n), count: n)
        //计算结果值
        var resultNum = n*n
        //填充矩阵
        var rowBegin = 0
        var rowEnd = n-1
        var columnBegin = 0
        var columnEnd = n-1
        var insertNum = 1
        while insertNum <= resultNum {
            //填充矩阵的上边，从左到右填充一行
            //每次h循环行不变，列+1，并且循环结束后行+1
            var columnTemp = columnBegin
            while columnTemp <= columnEnd {
                matrix[rowBegin][columnTemp] = insertNum
                insertNum += 1
                columnTemp += 1
            }
            rowBegin += 1
            
            //填充矩阵的右边，从上到下填充一列
            //每次循环列不变，行+1，并且循环结束后列-1
            var rowTemp = rowBegin
            while rowTemp <= rowEnd{
                matrix[rowTemp][columnEnd] = insertNum
                insertNum += 1
                rowTemp += 1
            }
            columnEnd -= 1
            
            //填充矩阵的下边，从右到左填充一行（注意只有一行的情况）
            //每次循环不变，列-1，并且循环结束后行+1
            columnTemp = columnEnd
            while columnTemp >= columnBegin && rowEnd >= rowBegin{
                matrix[rowEnd][columnTemp] = insertNum
                insertNum += 1
                columnTemp -= 1
            }
            rowEnd -= 1
            
            //填充矩阵的左边，从下到上填充一列（注意只有一列的情况）
            //每次循环不变，行+1，并且循环结束后列+1
            rowTemp = rowEnd
            while rowTemp >= rowBegin && columnEnd >= columnBegin {
                matrix[rowTemp][columnBegin] = insertNum
                insertNum += 1
                rowTemp -= 1
            }
            columnBegin += 1
            
        }
        
        return matrix
    }
    class func generateMatrix2(_ n: Int) -> [[Int]] {
        /*
         O(n^2)
         暴力法
         思路：一圈一圈打印 从外向里，每一行或每一列打印时候 注意留下一个
         */
        
        //构建矩阵
        var matrix : [[Int]] = [[Int]].init(repeating: [Int].init(repeating: 0, count: n), count: n)
        //每一圈左边的起始位置和右边的结束位置，由于是正方形座椅列相同
        var left = 0, right = n-1
        //填充的数字
        var insertNum = 1
        
        while left <= right {
            //最中间的一个
            if left == right {
                matrix[left][right] = insertNum
                insertNum += 1
            }
            //最上面一行，除去最后一个
            for i in left..<right {
                matrix[left][i] = insertNum
                insertNum += 1
            }
            //最右边一列，除去最后一个
            for i in left..<right{
                matrix[i][right] = insertNum
                insertNum += 1
            }
            //最下面一行，除去最后一个（逆序）
            var i = right
            while i > left{
                matrix[right][i] = insertNum
                insertNum += 1
                i -= 1
            }
            //最左边一行，除去最后一个（逆序）
            i = right
            while i > left {
                matrix[i][left] = insertNum
                 insertNum += 1
                 i -= 1
            }
            
            left += 1
            right -= 1
        }
        
        return matrix
    }
    class func generateMatrix3(_ n: Int) -> [[Int]] {
        /*
         思路：判断边界条件
         */
        
        //构建矩阵
        var matrix : [[Int]] = [[Int]].init(repeating: [Int].init(repeating: 0, count: n), count: n)
        var insertNum = 1
        var i = 0
        while i<(n+1)/2 {
            var j = i
            while j < n-i {
                //四周终止位置
                let l = i, u=i, r=n-1-i, d=n-1-i
                //上
                var k = i
                while k <= r{
                    matrix[u][k] = insertNum
                    insertNum += 1
                    k += 1
                }
                //右
                k = i+1
                while k <= d{
                    matrix[k][r] = insertNum
                    insertNum += 1
                    k += 1
                }
                
                //下
                k = r-1
                while k >= l{
                    matrix[d][k] = insertNum
                    insertNum += 1
                    k -= 1
                }
                
                //左
                k = d-1
                while k > u{
                    matrix[k][l] = insertNum
                    insertNum += 1
                    k -= 1
                }
                
                
                i += 1
            }
            i += 1
        }
        
        return matrix
    }
    //MARK:-----------旋转链表
    class func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        /*
         思想：O(n)
         链表中的点已经相连，一次旋转操作意味着：
         先将链表闭合成环
         找到相应的位置断开这个环，确定新的链表头和链表尾

         算法步骤：
         找到旧的尾部并将其与链表头相连 old_tail.next = head，整个链表闭合成环，同时计算出链表的长度 n。
         找到新的尾部，第 (n - k % n - 1) 个节点 ，新的链表头是第 (n - k % n) 个节点。
         断开环 new_tail.next = None，并返回新的链表头 new_head。
         */
        if head==nil {
            return nil
        }
        if  head?.next == nil {
            return head
        }
        
        //将链表闭合成环
        var old_tail : ListNode? = head
        //代表链表的长度
        var n : Int = 1
        while old_tail?.next != nil {
            old_tail = old_tail?.next
            n += 1
        }
        old_tail?.next = head
        
        //找到新的尾部：(n - k % n - 1)
        //新的头部：(n - k % n)
        var new_tail : ListNode? = head
        var i = 0
        while i<n-k%n-1{
            new_tail = new_tail?.next
            i += 1
        }
        let new_head : ListNode? = new_tail?.next
        
        //断开环
        new_tail?.next = nil
        
        return new_head
    }
    class func rotateRight1(_ head: ListNode?, _ k: Int) -> ListNode? {
        /*
         思想：右移k个位置，本质就是将前 len - k % len 个节点放到最后去
         
         分为几个核心步骤：
         求出链表的长度，以及最后的一个节点
         截取前 len - k % len 个节点
         将两段链表进行拼接
         算法解释：利用dummyHead减少算法理解成本
         */
        if head==nil {
            return nil
        }
        if  head?.next == nil {
            return head
        }
        
        let dummyHead : ListNode? = ListNode(-1)
        dummyHead?.next = head
        var p = dummyHead
        
        //整个链表的长度
        var len = 0
        while p?.next != nil {
            p = p?.next
            len += 1
        }
        
        //得到最后一个节点
        var last : ListNode? = p
        
        //截取 前 len-k%len 个节点
        var k = k % len
        k = len - k
        p = dummyHead
        while k > 0 {
            p = p?.next
            k -= 1
        }
        //将两段链表进行拼接
        last?.next = dummyHead?.next
        dummyHead?.next = p?.next
        p?.next = nil
        
        return dummyHead?.next
        
        
    }
    class func rotateRight2(_ head: ListNode?, _ k: Int) -> ListNode? {
        /*
         思想：利用双指针
         步骤：O(n)
         1.求链表长度，然后用k膜一下长度，这样才是真正的右移k位
         2.双指针，快指针先走k步，然后再和慢指针一起一次走一步，当快指针到结尾的时候，慢指针到倒数第k个节点
         3.这个时候指来指去就行了
         */
        if head==nil {
            return nil
        }
        if  head?.next == nil {
            return head
        }
        var length = 0
        var cur : ListNode? = head
        while cur != nil {
            cur = cur?.next
            length += 1
        }
        cur = head
        var k = k % length
        
        var lastK : ListNode? = head
        //快指针先走k步
        for _ in 0..<k {
            cur = cur?.next
        }
        //在和慢指针一起一次走一步
        while cur?.next != nil {
            cur = cur?.next
            lastK = lastK?.next
        }
        
        cur?.next = head
        var res = lastK?.next
        lastK?.next = nil
        
        return res
        
    }
    
    
    //MARK:-----------不同路径
    class func uniquePaths(_ m: Int, _ n: Int) -> Int {
        /*
         思路：动态规划--16ms
         
         我们令 dp[i][j] 是到达 i, j 最多路径
         动态方程：dp[i][j] = dp[i-1][j] + dp[i][j-1]
         注意，对于第一行 dp[0][j]，或者第一列 dp[i][0]，由于都是在边界，所以只能为 1
         时间复杂度：O(m*n)
         空间复杂度：O(m*n)
         优化：因为我们每次只需要 dp[i-1][j],dp[i][j-1]
         所以我们只要记录这两个数
         */
        var dp : [[Int]] = [[Int]].init(repeating: [Int].init(repeating: 0, count: n), count: m)
        for i in 0..<n {
            dp[0][i] = 1
        }
        for i in 0..<m {
            dp[i][0] = 1
        }
        for i in 1..<m {
            for j in 1..<n {
                dp[i][j] = dp[i-1][j] + dp[i][j-1]
            }
        }
        return dp[m-1][n-1]
    }
    //优化空间复杂度O(2n)--8ms
    class func uniquePaths1(_ m: Int, _ n: Int) -> Int {
        var pre : [Int] = [Int].init(repeating: 1, count: n)
        var cur : [Int] = [Int].init(repeating: 1, count: n)
        for i in 1..<m {
            for j in 1..<n {
                cur[j] = cur[j-1]+pre[j]
            }
            pre = cur
        }
        return pre[n-1]
    }
    //优化空间复杂度O(n)--8ms
    class func uniquePaths2(_ m: Int, _ n: Int) -> Int {
        var cur : [Int] = [Int].init(repeating: 1, count: n)
        for i in 1..<m {
            for j in 1..<n {
                cur[j] += cur[j-1]
            }
        }
        return cur[n-1]
    }
    class func uniquePaths3(_ m: Int, _ n: Int) -> Int {
        /*  12ms
         与4相比
         要做的就是要省略压栈的过程，直接出栈。很明显可以做到的，只需要初始化最后一列为 1 ，然后 1 列，1 列的向前更新就可以了。有一些动态规划的思想了。
         */
        //初始化最后一列
        var dp : [Int] = [Int].init(repeating: 1, count: m)
        //从右向左更新所有列
        var i = n-2
        while i >= 0 {
            //最后一行永远是1，所以从倒数第2行开始
            //从下往上更新所有行
            var j = m-2
            while j >= 0{
                dp[j] = dp[j] + dp[j+1]
                j -= 1
            }
            i -= 1
        }
        return dp[0]
    }
    class func uniquePaths4(_ m: Int, _ n: Int) -> Int {
       /*
         //leetcode超出时间限制
         求 ( 0 , 0 ) 点到（ m - 1 , n - 1） 点的走法。
         （0，0）点到（m - 1 , n - 1） 点的走法等于（0，0）点右边的点 （1，0）到（m - 1 , n - 1）的走法加上（0，0）点下边的点（0，1）到（m - 1 , n - 1）的走法。
         而左边的点（1，0）点到（m - 1 , n - 1） 点的走法等于（2，0） 点到（m - 1 , n - 1）的走法加上（1，1）点到（m - 1 , n - 1）的走法。
         下边的点（0，1）点到（m - 1 , n - 1） 点的走法等于（1，1）点到（m - 1 , n - 1）的走法加上（0，2）点到（m - 1 , n - 1）的走法。
         然后一直递归下去，直到 （m - 1 , n - 1） 点到（m - 1 , n - 1） ，返回 1。
         
         问题出在当我们求点 （x，y）到（m - 1 , n - 1） 点的走法的时候，递归求了点 （x，y）点右边的点 （x + 1，0）到（m - 1 , n - 1）的走法和（x，y）下边的点（x，y + 1）到（m - 1 , n - 1）的走法。而没有考虑到（x + 1，0）到（m - 1 , n - 1）的走法和点（x，y + 1）到（m - 1 , n - 1）的走法是否是之前已经求过了。事实上，很多点求的时候后边的的点已经求过了，所以再进行递归是没有必要的。基于此，我们可以用 visited 保存已经求过的点。
         */
        var visited : [String : Int] = [String : Int]()
        return getAns(0, 0, m-1, n-1, 0, visited)
    }
    private class func getAns(_ x : Int, _ y : Int, _ m : Int, _ n : Int,_ num : Int, _ visited : [String : Int])->Int{
        var visited = visited
        if x == m && y == n {
            return 1
        }
        
        var n1 = 0
        var n2 = 0
        var key : String = String(x+1)+"@"+String(y)
        //判断当前点是否已经求过了
        if visited[key] == nil {
            if x+1 <= m {
                n1 = getAns(x+1, y, m, n, num, visited)
            }
        }else{
            n1 = visited[key]!
        }
        key = String(x)+"@"+String(y+1)
        if visited[key] == nil {
            if y+1 <= n {
                n2 = getAns(x, y+1, m, n, num, visited)
            }
        }else{
            n2 = visited[key]!
        }
        
        //将当前点加入visited中
        key = String(x)+"@"+String(y)
        visited[key] = n1+n2
        
        return n1+n2
    }
    class func uniquePaths5(_ m: Int, _ n: Int) -> Int {
        /* 8ms
         O(m*n)
         就是从左向右，从上到下一行一行更新（当前也可以一列一列更新）
         */
        //初始化最后一列
        var dp : [Int] = [Int].init(repeating: 1, count: n)
        for i in 1..<m {
            for j in 1..<n {
                dp[j] = dp[j]+dp[j-1]
            }
        }
        return dp[n-1]
    }
    class func uniquePaths6(_ m: Int, _ n: Int) -> Int {
        /* 4ms
         思想：公式O(m)
         我们用 R 表示向右，D 表示向下，然后把所有路线写出来，就会发现神奇的事情了。
         
         R R R D D
         
         R R D D R
         
         R D R D R
         
         ……
         
         从左上角，到右下角，总会是 3 个 R，2 个 D，只是出现的顺序不一样。所以求解法，本质上是求了组合数，N = m + n - 2，也就是总共走的步数。 k = m - 1，也就是向下的步数，D 的个数。所以总共的解就是
         N = m + n - 2，也就是总共走的步数。 k = m - 1，也就是向下的步数，D 的个数。所以总共的解就是
         Cnk=n!/(k!(n−k)!)=(n∗(n−1)∗(n−2)∗...(n−k+1))/k!
         */
        //初始化最后一列
        let N = n+m-2
        let k = m-1
        var res = 1
        var i = 1
        while i <= k{
            res = res * (N-k+i) / i
            i += 1
        }
        return res
    }
    //MARK:-----------爬楼梯
    class func climbStairs(_ n: Int) -> Int {
        /*
         暴力法：O(2^n) leetcode时间超出限制
         我们将会把所有可能爬的阶数进行组合，也就是 1 和 2 。而在每一步中我们都会继续调用climbStairs 这个函数模拟爬
         2 阶的情形，并返回两个函数的返回值之和。
         climbStairs(i,n)=(i+1,n)+climbStairs(i+2,n)
         其中 i 定义了当前阶数，而n 定义了目标阶数。
         */
        return climb_Stairs(0, n)
    }
    private class func climb_Stairs(_ i : Int, _ n : Int)-> Int{
        if i > n {
            return 0
        }
        if i == n {
            return 1
        }
        return climb_Stairs(i+1, n)+climb_Stairs(i+2, n)
    }
    class func climbStairs1(_ n: Int) -> Int {
        /*
         记忆化递归：O(n) 12ms
         在上一种方法中，我们计算每一步的结果时出现了冗余。另一种思路是，我们可以把每一步的结果存储在memo 数组之中，每当函数再次被调用，我们就直接从memo 数组返回结果。
         在memo 数组的帮助下，我们得到了一个修复的递归树，其大小减少到n。
         */
        var memo : [Int] = [Int].init(repeating: 0, count: n+1)
        return climb_Stairs1(0, n, &memo)
    }
    private class func climb_Stairs1(_ i : Int, _ n : Int, _ memo : inout [Int])-> Int{
        if i > n {
            return 0
        }
        if i == n {
            return 1
        }
        if memo[i] > 0 {
            return memo[i]
        }
        memo[i] = climb_Stairs1(i+1, n, &memo)+climb_Stairs1(i+2, n, &memo)
        return memo[i]
    }
    class func climbStairs2(_ n: Int) -> Int {
        /*
         动态规划：O(n) 它的最优解可以从其子问题的最优解来有效的构建 leetcode 12ms
         第i阶可以由以下两种方法得到：
            1）在第（i-1）阶后向上爬1阶
            2）在第（i-2）阶后向上爬2阶
         所以到达第i阶的方法总数就是到第（i-1）阶和第（i-2）阶的方法数之和
         令dp[i]表示能到达第i阶的方法总数：dp[i] = dp[i-1]+dp[i-2]
         */
        if n==1 {
            return 1
        }
        
        var dp : [Int] = [Int].init(repeating: 0, count: n+1)
        dp[1] = 1
        dp[2] = 2
        var i = 3
        while i<=n {
            dp[i] = dp[i-1]+dp[i-2]
            i += 1
        }
        return dp[n]
    }
    class func climbStairs3(_ n: Int) -> Int {
        /*
         斐波那契数：O(n) 8ms
         由动态规划式子dp[i] = dp[i-1]+dp[i-2]分析，可以很容易的得出dp[i]就是第i个斐波那契数
         Fib(n) = Fib(n-1) + Fib(n-2)
         我们必须以找出以1和2作为第一项和第二项的斐波那契数列中的第n个数，也就是说Fib(1) = 1，Fib(2) = 2
         */
        if n==1 {
            return 1
        }
        
        var first = 1
        var second = 2
        var i = 3
        while i<=n {
            var third = first+second
            first = second
            second = third
            
            i += 1
        }
        return second
    }
    class func climbStairs4(_ n: Int) -> Int {
        /*
         斐波那契公式：O(logn)pow 方法将会用去log(n) 的时间。 16ms
         Fn = 1/根号5[（(1+根号5)/2）^n - (1-根号5)/2）^n]
         */
        let sqrt5 : Double = sqrt(5)
        let fibn : Double = pow((1+sqrt5)/2, Double(n+1))-pow((1-sqrt5)/2, Double(n+1))
        return Int(fibn/sqrt5)
    }
    //MARK:-----------子集
    class func subsets(_ nums: [Int]) -> [[Int]] {
        /*
         二进制位
         集合的每个元素，都有可以选或不选，用二进制和位运算，可以很好的表示
         */
        var res : [[Int]] = [[Int]]()
        for i in 0..<(1<<nums.count) {
            var sub = [Int]()
            for j in 0..<nums.count{
                if ((i>>j)&1) == 1 {
                    sub.append(nums[j])
                }
            }
            res.append(sub)
        }
        return res
    }
    class func subsets1(_ nums: [Int]) -> [[Int]] {
        /*
         逐个枚举
         逐个枚举，空集的幂集只有空集，每增加一个元素，让之前幂集中的每个集合，追加这个元素，就是新增的子集
         */
        //循环枚举
        var res : [[Int]] = [[Int]]()
        res.append([])
        for n in nums {
            let size = res.count
            var i = 0
            while i<size{
                var sub = [Int](res[i])
                sub.append(n)
                res.append(sub)
                i += 1
            }
        }
        return res
    }
    class func subsets2(_ nums: [Int]) -> [[Int]] {
        /*
         递归枚举
         */
        var res : [[Int]] = [[Int]]()
        res.append([])
        recursion(nums, 0, &res)
        return res
    }
    private class func recursion(_ nums : [Int], _ i : Int, _ res : inout [[Int]]){
        if i >= nums.count{
            return
        }
        let size = res.count
        var j = 0
        while j < size{
            var sub = [Int](res[j])
            sub.append(nums[i])
            res.append(sub)
            j += 1
        }
        recursion(nums, i+1, &res)
    }
    class func subsets3(_ nums: [Int]) -> [[Int]] {
        /*
         回溯
         集合中每个元素的选和不选，构成了一个满二叉状态树，比如，左子树是不选，右子树是选，从根节点、到叶子节点的所有路径，构成了所有子集。通过回溯，跳过一些节点
         */
        var res : [[Int]] = [[Int]]()
        var sub : [Int] = [Int]()
        backtrace(nums, 0, &sub, &res)
        return res
    }
    private class func backtrace(_ nums : [Int], _ i : Int, _ sub : inout [Int], _ res : inout [[Int]]){
        res.append(sub)
        var j = i
        while j < nums.count {
            sub.append(nums[j])
            backtrace(nums, j+1, &sub, &res)
            sub.remove(at: sub.count-1)
            j += 1
        }
    }
    class func subsets4(_ nums: [Int]) -> [[Int]] {
        /*
         迭代一
         解法一的迭代法，是直接从结果上进行分类，将子数组的长度分为长度是 1 的，2 的 .... n 的。
         想找出数组长度 1 的所有解，然后再在长度为 1 的所有解上加 1 个数字变成长度为 2 的所有解，同样的直到 n。
         第一次循环：     [1]           [2]        [3]
         第二次循环：[1, 2] [1, 3]    [2, 3]
         第三次循环：[1, 2, 3]
         */
        var res : [[Int]] = [[Int]]()
        var ans : [[Int]] = [[Int]]()
        ans.append([])
        res.append([])
        let n = nums.count
        //第一层循环，子数组长度从1到n
        for i in 1...n {
            //第二层循环，遍历上次的所有结果
            var tmp : [[Int]] = [[Int]]()
            for list in res {
                //第三次循环，对每个结果进行扩展
                for m in 0..<n {
                    //只添加比末尾数字答的数字，防止重复
                    if list.count>0 && list[list.count-1]>=nums[m] {
                        continue
                    }
                    var newList = [Int](list)
                    newList.append(nums[m])
                    tmp.append(newList)
                    res.append(newList)
                }
            }
            ans=tmp
        }
        return res
    }
    class func subsets5(_ nums: [Int]) -> [[Int]] {
        /*
         迭代二
         我们还可以从条件上入手，先只考虑给定数组的 1 个元素的所有子数组，然后再考虑数组的 2 个元素的所有子数组 ... 最后再考虑数组的 n 个元素的所有子数组。求 k 个元素的所有子数组，只需要在 k - 1 个元素的所有子数组里边加上 nums [ k ] 即可。
                                                    []      -->  初始化空
                                            []      [1]     -->   [1]
                                []  [1]     [2]     [1,2]   -->   [1,2]
            []  [1] [2] [1, 2]  [3] [1,3]   [2,3]   [1,2,3] -->   [1,2,3]
         */
        var res : [[Int]] = [[Int]]()
        res.append([])//初始化空数组
        for i in 0..<nums.count {
            var res_tmp = [[Int]]()
            //遍历之前的所有结果
            for list in res {
                var tmp = [Int](list)
                //加入新增数字
                tmp.append(nums[i])
                res_tmp.append(tmp)
            }
            res.append(contentsOf: res_tmp)
        }
        return res
    }
    //MARK:-----------
    //MARK:-----------
    //MARK:-----------
    //MARK:-----------
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


//MARK:---------leetcode算法调用
func algorithmTest(){
    let nums = [-1, 2, 1, -4]
    let result = Algorithm.threeSumClosest(nums, 1)
    print("result \(result)")
    
    //有效括号
    print("result \(Algorithm.isValid("()"))")
    print("result \(Algorithm.isValid("()[]{}"))")
    print("result \(Algorithm.isValid("(]"))")
    print("result \(Algorithm.isValid("([)]"))")
    
    //合并两个有序链表
    var node1 = ListNode(1)
    let node2 = ListNode(2)
    let node3 = ListNode(4)
    node1.next = node2
    node2.next = node3
    let node4 = ListNode(1)
    let node5 = ListNode(3)
    let node6 = ListNode(4)
    node4.next = node5
    node5.next = node6
    //        var node = Algorithm.mergeTwoLists(node1, node4)
    //        var array : [Int] = [Int]()
    //        while node != nil {
    //            array.append((node?.val)!)
    //            node = node?.next
    //        }
    //        print("result ", array)
    
    //        var node11 = Algorithm.mergeTwoLists1(node1, node4)
    //        var array11 : [Int] = [Int]()
    //        while node11 != nil {
    //            array11.append((node11?.val)!)
    //            node11 = node11?.next
    //        }
    //        print("result ", array11)
    
    let node7 = ListNode(2)
    let node8 = ListNode(6)
    node7.next = node8
    let node9 = ListNode(1)
    let node10 = ListNode(4)
    let node11 = ListNode(5)
    node9.next = node10
    node10.next = node11
    var nodeArr = [node9, node4,node7]
    var node22 = Algorithm.mergeKLists(nodeArr)
    //        var node22 = Algorithm.mergeKLists2(nodeArr)
    var array22 : [Int] = [Int]()
    while node22 != nil {
        array22.append((node22?.val)!)
        node22 = node22?.next
    }
    print("result ", array22)
    
    
    //删除排序数组中的重复项
    var nums1 = [1, 1, 2]
    var nums2 = [0, 0, 1, 1, 1, 2, 2, 3, 3 ,4]
    //        print("result \(Algorithm.removeDuplicates(&nums1))")
    //        print("result \(Algorithm.removeDuplicates(&nums2))")
    print("result \(Algorithm.removeDuplicates1(&nums1))")
    print("result \(Algorithm.removeDuplicates1(&nums2))")
    print("\n")
    
    //搜索旋转排序数组
    print("搜索旋转排序数组")
    var num3 = [4, 5, 6, 7, 0, 1, 2]
    print(Algorithm.search(num3, 0), Algorithm.search(num3, 3))
    print(Algorithm.search1(num3, 0), Algorithm.search1(num3, 3))
    print(Algorithm.search2(num3, 0), Algorithm.search2(num3, 3))
    print(Algorithm.search3(num3, 0), Algorithm.search3(num3, 3))
    print("\n")
    
    //字符串相乘
    print("字符串相乘")
    print(Algorithm.multiply("2", "3"))
    print(Algorithm.multiply("123", "456"))
    print(Algorithm.multiply2("2", "3"))
    print(Algorithm.multiply2("123", "456"))
    print("\n")
    
    //全排列
    print("全排列")
    print(Algorithm.permute([1, 2, 3]))
    print("\n")
    
    //最大子序和
    print("最大子序和")
    print(Algorithm.maxSubArray([-2, 3, -1, 1, -3]))
    print(Algorithm.maxSubArray1([-2, 3, -1, 1, -3]))
    print(Algorithm.maxSubArray2([-2, 3, -1, 1, -3]))
    print(Algorithm.maxSubArray3([-2, 3, -1, 1, -3]))
    print(Algorithm.maxSubArray3([-2, -1]))
    print("\n")
    
    //螺旋矩阵
    print("螺旋矩阵")
    print(Algorithm.spiralOrder([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
    print(Algorithm.spiralOrder2([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
    print(Algorithm.spiralOrder3([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
    print("\n")
    
    print("螺旋矩阵II")
    print(Algorithm.generateMatrix(3))
    print(Algorithm.generateMatrix2(3))
    print(Algorithm.generateMatrix3(3))
    print("\n")
    
    print("旋转链表")
    let node12 = ListNode(1)
    let node13 = ListNode(2)
    let node14 = ListNode(3)
    let node15 = ListNode(4)
    let node16 = ListNode(5)
    node12.next = node13
    node13.next = node14
    node14.next = node15
    node15.next = node16
    node16.next = nil
    var node23 = Algorithm.rotateRight(node12, 2)
    //        var node23 = Algorithm.rotateRight1(node12, 2)
    //        var node23 = Algorithm.rotateRight2(node12, 2)
    var array23 : [Int] = [Int]()
    while node23 != nil {
        array23.append((node23?.val)!)
        node23 = node23?.next
    }
    print(array23)
    print("\n")
    
    print("不同路径")
    print(Algorithm.uniquePaths(7, 3))
    print(Algorithm.uniquePaths1(7, 3))
    print(Algorithm.uniquePaths2(7, 3))
    print(Algorithm.uniquePaths3(7, 3))
    print(Algorithm.uniquePaths4(7, 3))
    print(Algorithm.uniquePaths5(7, 3))
    print(Algorithm.uniquePaths6(7, 3))
    print("\n")
    
    print("爬楼梯")
    print(Algorithm.climbStairs(2))
    print(Algorithm.climbStairs1(3))
    print(Algorithm.climbStairs2(3))
    print(Algorithm.climbStairs3(3))
    print(Algorithm.climbStairs4(3))
    print("\n")
    
    print("子集")
    print(Algorithm.subsets([1, 2, 3]))
    print(Algorithm.subsets1([1, 2, 3]))
    print(Algorithm.subsets2([1, 2, 3]))
    print(Algorithm.subsets3([1, 2, 3]))
    print(Algorithm.subsets4([1, 2, 3]))
    print(Algorithm.subsets5([1, 2, 3]))
    print("\n")
    
}
