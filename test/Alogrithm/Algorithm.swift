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
         二进制位 16ms
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
         逐个枚举 16ms
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
         递归枚举 20ms
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
         回溯 12ms
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
         迭代一 36ms
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
                    ans.append(newList)
                }
            }
            res=tmp
        }
        return ans
    }
    class func subsets5(_ nums: [Int]) -> [[Int]] {
        /*
         迭代二 20ms
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
    //MARK:-----------合并两个有序数组
    class func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        /*
         合并后排序 20ms
         */
        nums1 = [Int](nums1[0..<m])
        for num in nums2 {
            nums1.append(num)
        }
        nums1 = nums1.sorted()
        print(nums1)
    }
    class func merge1(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        /*
         从前往后排序 O(n) 40ms
         */
        if m==0 {
            nums1 = nums2
        }
        var num = [Int]()
        var newNum1 = [Int](nums1[0..<m])
        var nums2 : [Int] = nums2
        while !newNum1.isEmpty && !nums2.isEmpty {
            if newNum1.first! <= nums2.first!{
                num.append(newNum1.first!)
                newNum1.removeFirst()
            }else{
                num.append(nums2.first!)
                nums2.removeFirst()
            }
            if newNum1.isEmpty {
                num.append(contentsOf: nums2)
                nums1 = num
            }
            if nums2.isEmpty{
                num.append(contentsOf: newNum1)
                nums1 = num
            }
        }
        print(nums1)
        
    }
    class func merge2(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        //双指针 从后往前 20ms
        var p1 = m-1
        var p2 = n-1
        var p = m+n-1
        while p1>=0 && p2>=0 {
            if  nums1[p1] <= nums2[p2]{
                nums1[p] = nums2[p2]
                p2 -= 1
                p -= 1
            }else{
                nums1[p] = nums1[p1]
                p1 -= 1
                p -= 1
                
            }
        }
        while p2 >= 0 {
            nums1[p] = nums2[p2]
            p -= 1
            p2 -= 1
        }
    }
    //MARK:-----------格雷编码
    class func grayCode(_ n: Int) -> [Int] {
        /*
         动态规划：O(2^n)镜射排列 12ms
         如果知道了 n = 2 的解的话，如果是 { 0, 1, 3, 2}，那么 n = 3 的解就是 { 0, 1, 3, 2, 2 + 4, 3 + 4, 1 + 4, 0 + 4 }，即 { 0 1 3 2 6 7 5 4 }。之前的解直接照搬过来，然后倒序把每个数加上 1 << ( n - 1) 添加到结果中即可。
         */
        var gray : [Int] = [Int]()
        //初始化n=0的解
        gray.append(0)
        for i in 0..<n{
            //要加的数
            let add : Int = 1 << i
            //倒序遍历，并且加上一个值添加到结果中
            var j = gray.count-1
            while j >= 0{
                gray.append(gray[j]+add)
                j -= 1
            }
        }
        return gray
    }
    class func grayCode1(_ n: Int) -> [Int] {
        /*
         直接推导（直接排列）：16ms
         由于每添加两个数需要找第一个为 1 的位元，需要 O（n）,O(n2^n)
         生成格雷码的思路：以二进制为 0 值的格雷码为第零项，第一项改变最右边的位元，第二项改变右起第一个为1的位元的左边位元，第三、四项方法同第一、二项，如此反复，即可排列出n个位元的格雷码。
         以 n = 3 为例。
         0 0 0 第零项初始化为 0。
         0 0 1 第一项改变上一项最右边的位元
         0 1 1 第二项改变上一项右起第一个为 1 的位元的左边位
         0 1 0 第三项同第一项，改变上一项最右边的位元
         1 1 0 第四项同第二项，改变最上一项右起第一个为 1 的位元的左边位
         1 1 1 第五项同第一项，改变上一项最右边的位元
         1 0 1 第六项同第二项，改变最上一项右起第一个为 1 的位元的左边位
         1 0 0 第七项同第一项，改变上一项最右边的位元
         */
        var gray : [Int] = [Int]()
        //初始化n=0的解
        gray.append(0)
        var i = 1
        while i < 1 << n{
            //得到上一个的值
            var previous = gray[i-1]
            //同一项的情况
            if i%2 == 1 {
                //和0000001 做异或，使得最右边一位取反
                previous = previous ^ 1
                gray.append(previous)
            //同第二项的情况
            }else{
                var temp = previous
                //寻找右边起第一个为1的位元
                for j in 0..<n {
                    if temp&1 == 1 {
                        //和 00001000000 类似这样的数做异或，使得相应位取反
                        previous = previous^(1<<(j+1))
                        gray.append(previous)
                        break
                    }
                    temp = temp>>1
                }
            }
            i += 1
        }
        return gray
    }
    class func grayCode2(_ n: Int) -> [Int] {
        /*
         公式：O(2^n) 20ms
         二进制转格雷码 G(n)=B(n+1) XOR B(n)
         利用公式转换即可。即最高位保留，其它位是当前位和它的高一位进行异或操作。
         */
        var gray : [Int] = [Int]()
        var binary = 0
        while binary < 1 << n {
            gray.append(binary ^ (binary>>1))
            binary += 1
        }
        return gray
    }
    //MARK:-----------二叉树的最大深度
    class func maxDepth(_ root: TreeNode?) -> Int {
        /*
         递归：深度优先搜索DFS O(n) 40ms
         */
        guard root != nil else{
            return 0
        }
        let left_height = maxDepth(root?.left)
        let right_height = maxDepth(root?.right)
        return max(left_height, right_height)+1
    }
    class func maxDepth1(_ root: TreeNode?) -> Int {
        /*
         迭代：68ms
         利用栈将递归转换为迭代，使用dfs策略访问每个节点，同时在每次访问时更新最大深度
         O(n)
         从包含根结点且相应深度为 1 的栈开始。然后我们继续迭代：将当前结点弹出栈并推入子结点。每一步都会更新深度。
         */
        var stack : [(TreeNode?,Int)] = []
        if root != nil {
            stack.append((root,1))
        }else{
            return 0
        }
        var depth = 1
        while !stack.isEmpty {
            let current = stack.removeFirst()
            let root : TreeNode? = current.0
            let current_depth = current.1
            if root != nil{
                depth = max(depth, current_depth)
                stack.append((root?.left, current_depth+1))
                stack.append((root?.right, current_depth+1))
            }
        }
        return depth
    }
    //MARK:-----------买卖股票的最佳时机
    class func maxProfit(_ prices: [Int]) -> Int {
        /*
         暴力法：O(n^2) 3660ms
         我们需要找出给定数组中两个数字之间的最大差值（即，最大利润）。此外，第二个数字（卖出价格）必须大于第一个数字（买入价格）。
         形式上，对于每组i 和j（其中j>i）我们需要找出max(prices[j]−prices[i])。
         */
        if prices.count==0 || prices.count==1{
            return 0
        }
        var maxprofit : Int = 0
        for i in 0..<prices.count-1 {
            for j in (i+1)..<prices.count{
                let profit = prices[j]-prices[i]
                if profit > maxprofit {
                    maxprofit = profit
                }
            }
        }
        return maxprofit
    }
    class func maxProfit1(_ prices: [Int]) -> Int {
        /*
         一次遍历：O(n)  56ms
         需要找到最小的谷之后的最大的峰。 我们可以维持两个变量——minprice 和 maxprofit，它们分别对应迄今为止所得到的最小的谷值和最大的利润（卖出价格与最低价格之间的最大差值）。
         */
        var minprice = Int.max
        var maxprofit : Int = 0
        for i in 0..<prices.count {
            if prices[i] < minprice{
                minprice = prices[i]
            }else if prices[i] - minprice > maxprofit{
                maxprofit = prices[i]-minprice
            }
        }
        return maxprofit
    }
    class func maxProfit2(_ prices: [Int]) -> Int {
        /*
         一次遍历：O(n) 60ms
         直接把最小值放在数组的第一位
         */
        if prices.count==0 || prices.count==1{
            return 0
        }
        var minprice = prices[0]
        var maxprofit : Int = 0
        for i in 1..<prices.count {
            if prices[i] > minprice{
                maxprofit = prices[i]-minprice > maxprofit ? prices[i]-minprice : maxprofit
            }else{
                minprice = prices[i]
            }
        }
        return maxprofit
    }
    class func maxProfit3(_ prices: [Int]) -> Int {
        /*
         快排思想：64ms
         根据最大值一定在最小值之前-->三路快排思想
         
         1）当接下来的数字比最小数还要小 那么我们重新更新maxIndex和minIndex即可 并且记录归零之前的最大间隔
         2）记录最大间隔引入循环外变量
         3）当接下来的数字比最大值还大 我们只需要更新maxIndex即可 同时得更新money
         */
        if prices.count==0 || prices.count==1{
            return 0
        }
        var maxprofit : Int = 0
        var minIndex = 0
        var maxIndex = 0
        for i in 1..<prices.count {
            if prices[i] < prices[minIndex] {
                maxIndex = i
                minIndex = i
            }else if prices[i] > prices[maxIndex]{
                maxIndex = i
                maxprofit = max(maxprofit, prices[maxIndex]-prices[minIndex])
            }
        }
        return maxprofit
    }
    //MARK:-----------买卖股票的最佳时机II
    class func maxProfitII(_ prices: [Int]) -> Int {
        /*
         一次遍历：O(n) 56ms
         继续在斜坡上爬升并持续增加从连续交易中获得的利润
         */
        if prices.count==0 || prices.count==1{
            return 0
        }
        var maxprofit : Int = 0
        for i in 1..<prices.count {
            if prices[i] > prices[i-1] {
                maxprofit += prices[i] - prices[i-1]
            }
        }
        return maxprofit
    }
    class func maxProfitII2(_ prices: [Int]) -> Int {
        /*
         暴力法:O(n^n)调用递归函数n^n次。 超出时间限制
         需要计算与所有可能的交易组合相对应的利润，并找出它们中的最大利润。
         */
        return calculate(prices, 0)
    }
    private class func calculate(_ prices : [Int], _ s : Int)->Int{
        if s >= prices.count {
            return 0
        }
        var max = 0
        for start in s..<prices.count {
            var maxpfrofit = 0
            for i in start+1..<prices.count {
                if prices[start] < prices[i] {
                    var profit = calculate(prices, i+1) + prices[i]-prices[start]
                    if profit > maxpfrofit{
                        maxpfrofit = profit
                    }
                }
            }
            if maxpfrofit > max {
                max = maxpfrofit
            }
        }
        return max
    }
    class func maxProfitII3(_ prices: [Int]) -> Int {
        /*
         峰谷法：O(n) 56ms
         TotalProfit=∑下i(height(peak下i)−height(valley下i))
         */
        if prices.count==0 || prices.count==1{
            return 0
        }
        var maxprofit : Int = 0
        var valley = prices[0]
        var peak = prices[0]
        var i = 0
        while i < prices.count-1 {
            while i < prices.count-1 && prices[i]>=prices[i+1]{
                i += 1
            }
            valley = prices[i]
            while i < prices.count-1 && prices[i] <= prices[i+1]{
                i += 1
            }
            peak = prices[i]
            maxprofit += peak - valley
        }
        return maxprofit
    }
    //MARK:-----------二叉树中的最大路径和
    
    class func maxPathSum(_ root: TreeNode?) -> Int {
        /*
         递归 140ms O(n)
         
         考虑实现一个简化的函数 max_gain(node) 计算它及其子树的最大贡献 即 计算包含这个顶点的最大权值路径
         步骤：
         1、初始化 max_sum 为最小可能的证书并调用 max_gain(node=root)
         2、实现 max_gain(node)检查是继续旧路径还是开始新路径
            1）边界情况：如果节点为空，那么最大权值是 0 。
            2）对该节点的所有孩子递归调用 max_gain，计算从左右子树的最大权值：left_gain = max(max_gain(node.left), 0) 和 right_gain = max(max_gain(node.right), 0)。
            3）检查是维护旧路径还是创建新路径。创建新路径的权值是：price_newpath = node.val + left_gain + right_gain，当新路径更好的时候更新 max_sum。
            4）对于递归返回的到当前节点的一条最大路径，计算结果为：node.val + max(left_gain, right_gain)。
         */
        
        var max_sum = Int.min
        max_gain(root, &max_sum)
        return max_sum
    }
    
    private class func max_gain(_ node : TreeNode?, _ max_sum : inout Int)->Int{
        
        if node == nil {
            return 0
        }
        //分别递归计算左右子树的最大路径和
        let left_gain = max(max_gain(node?.left, &max_sum), 0)
        let right_gain = max(max_gain(node?.right, &max_sum), 0)
        
        //创建新路径的权值
        let price_newpath = (node?.val)! + left_gain+right_gain
        
        //如果有更好的路径时，更新最大值
        max_sum = max(max_sum, price_newpath)
        
        return (node?.val)! + max(left_gain, right_gain)
    }
    //MARK:-----------只出现一次的数字
    class func singleNumber(_ nums: [Int]) -> Int {
        /*
         哈希表操作：140ms O(n)
         利用字典记录每个数字出现的次数，最后遍历数组找出只出现一次的数返回
         */
        var temp = [Int:Int]()
        for num in nums {
            if (temp[num] == nil){
                temp[num] = 1
            }else{
                temp.updateValue(temp[num]!+1, forKey: num)
            }
        }
        for (key, value) in temp {
            if value == 1{
                return key
            }else{
                continue
            }
        }
        return 0
    }
    class func singleNumber1(_ nums: [Int]) -> Int {
        /*
         列表操作：O(n^2) 超出时间限制
         利用数组，遍历nums中的每一个元素，如果是新出现则加入数组，如果已经在列表则删除
         */
        var temp = [Int]()
        for value in nums {
            if temp.contains(value){
                temp = temp.filter{$0 != value }
            }else{
                temp.append(value)
            }
        }
        return temp.first!
    }
    class func singleNumber2(_ nums: [Int]) -> Int {
        /*
         异或 O(n) 136ms
         */
        var temp = nums[0]
        if nums.count > 1{
            for i in 1..<nums.count {
                temp = temp ^ nums[i]
            }
        }
        
        return temp
    }
    //MARK:-----------环形链表
    class func hasCycle(_ head:ListNode?)->Bool{
        /*
         哈希表
         思路：可以通过检查一个结点此前是否被访问过来判断链表是否为环形链表
         算法：我们遍历所有结点并在哈希表中存储每个结点的引用（或内存地址）。如果当前结点为空结点 nil即以检测到链表尾部的下一个结点，那么我们已经遍历完整个链表，并且该链表不是环形链表。如果当前结点的引用已经存在于哈希表中，那么返回true即该链表为环形链表
         时间复杂度：O(n)，对于含有n 个元素的链表，我们访问每个元素最多一次。添加一个结点到哈希表中只需要花费O(1) 的时间。
         */
        var head = head
        var nodeSeen : [Int:ListNode?] = [:]
        while head != nil {
            if nodeSeen[(head?.val)!] != nil {
                return true
            }else{
                nodeSeen[(head?.val)!] = head
            }
            head = head?.next
        }
        return false
    }
    class func hasCycle2(_ head:ListNode?)->Bool{
        /*
         双指针
         思路：双指针
         算法：我们遍历所有结点并在哈希表中存储每个结点的引用（或内存地址）。如果当前结点为空结点 nil即以检测到链表尾部的下一个结点，那么我们已经遍历完整个链表，并且该链表不是环形链表。如果当前结点的引用已经存在于哈希表中，那么返回true即该链表为环形链表
         时间复杂度：O(n)，让我们将 n 设为链表中结点的总数。
         */
        if head == nil || head?.next == nil {
            return false
        }
        var slow = head
        var fast = head?.next
        while slow?.val != fast?.val {
            if fast == nil || fast?.next == nil{
                return false
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return true
    }
    //MARK:-----------环形链表II
    class func detectCycle(_ head:ListNode?)->ListNode?{
        /*
         哈希表
         我们分配一个 Set 去保存所有的列表节点。我们逐一遍历列表，检查当前节点是否出现过，如果节点已经出现过，那么一定形成了环且它是环的入口。否则如果有其他点是环的入口，我们应该先访问到其他节点而不是这个节点。其他情况，没有成环则直接返回 null
         */
        var head = head
        var nodeSeen : [Int:ListNode?] = [:]
        while head != nil {
            if nodeSeen[(head?.val)!] != nil {
                return head
            }else{
                nodeSeen[(head?.val)!] = head
            }
            head = head?.next
        }
        return nil
    }
    class func detectCycle2(_ head:ListNode?)->ListNode?{
        /*
         双指针
         思路：双指针
         算法：算法被划分成两个不同的 阶段 。在第一阶段，找出列表中是否有环，如果没有环，可以直接返回 null 并退出。否则，用 相遇节点 来找到环的入口。
         时间复杂度：O(n)，让我们将 n 设为链表中结点的总数。
         */
        if head == nil || head?.next == nil {
            return nil
        }
        //如果这里有一个环，快/慢指针就会有一个相遇节点，反之，返回nil
        let intersect = getIntersect(head)
        if intersect == nil {
            return nil
        }
        
        //用两个相同速度的指针，一个从链表头开始，一个从相遇节点开始，当它们指向同一个节点时，这个结点就是环的入口
        var ptr1 = head
        var ptr2 = intersect
        while ptr1?.val != ptr2?.val {
            ptr1 = ptr1?.next
            ptr2 = ptr2?.next
        }
        return ptr1
    }
    private class func getIntersect(_ head:ListNode?)->ListNode?{
        var tortoise = head
        var hare = head
        //快指针会遍历一圈环去遇见慢指针
        //如果没有环，则返回空
        while hare != nil && hare?.next != nil {
            tortoise = tortoise?.next
            hare = hare?.next?.next
            if tortoise?.val == hare?.val{
                return tortoise
            }
            
        }
        return nil
    }
    
    //MARK:-----------排序链表
    class func sortList(_ head : ListNode?)->ListNode?{
        /*
         11ms
         题目要求时间空间复杂度分别为O(nlogn)和O(1)，根据时间复杂度我们自然想到二分法，从而联想到归并排序
         1、分割cut环节： 找到当前链表中点，并从中点将链表断开（以便在下次递归时可以处理正确的链表片段）；
            1）我们使用fast,slow快慢双指针法，奇数个节点找到中点，偶数个节点找到中心左边的节点。
            2）找到中点slow后，执行slow.next = None将链表切断。
            3）递归分割时，输入当前链表左端点head和中心节点slow的下一个节点tmp(因为链表是从slow开始切断的)。
            4）递归终止条件： 当head.next == None时，说明只有一个节点了，直接返回此节点。
         2、合并merge环节： 将两个排序链表合并，转化为一个排序链表。
            双指针法合并，时间复杂度O(l + r)，l, r分别代表两个链表长度。
         3、当head == None时，直接返回None。
         */
        /*
         归并排序：
         1、递归使用二分法将链表分割成两个链表
            1）不过由于是单向链表，没法直接获得中间节点，需要循环先计算出链表的长度。
            2）通过 count/2 计算出中间的节点，注意分割后的链表的长度为count/2和（count-count/2）,考虑奇数问题
            3）找到中间节点后，把链表断成两个链表，不然各种判断会很复杂
         2、合并有序的链表
            1）第一步分到最后是单个元素的链表，可以看成有序链表
            2）实际上，这一步就转换成了合并两个有序的链表
            3）使用递归，每次只判断链表头，代码简洁且易懂
         */
        if head == nil || head?.next == nil {
            return head
        }
        
        //计算出链表的长度
        var countNode = head
        var count = 0
        while countNode != nil {
            count += 1
            countNode = countNode?.next
        }
        return sortList(head, count)
    }
    //排序链表
    private class func sortList(_ head : ListNode?, _ count : Int)->ListNode?{
        //递归结束条件
        if count <= 1{
            return head
        }
        var leftEnd = head
        for i in 0..<count/2-1{
            leftEnd = leftEnd?.next
        }
        var rightStart = leftEnd?.next
        //断链，如果不断链，各种判断让你死去活来
        leftEnd?.next = nil
        //合并两个已经排好序的链表
        //第二个链表的长度为count - count / 2，不能直接是count / 2，奇数计算会错误
        return merge(sortList(head, count/2), sortList(rightStart, count-count/2))
    }
    //合并两个有序的链表，使用递归更简洁，每次只比较两个链表的链头
    private class func merge(_ l1 : ListNode?, _ l2 : ListNode?)->ListNode?{
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        var l1 = l1
        var l2 = l2
        var head : ListNode?
        if l1!.val <= l2!.val {
            head = l1
            l1?.next = merge(l1?.next, l2)
        }else{
            head = l2
            l2?.next = merge(l1, l2?.next)
        }
        return head
    }
    
    //MARK:-----------相交链表
    class func getIntersectionNode(_ headA : ListNode?, _ headB : ListNode?)->ListNode?{
        /*
         双指针法O(n)
         
         根据题目意思 如果两个链表相交，那么相交点之后的长度是相同的
         
         我们需要做的事情是，让两个链表从同距离末尾同等距离的位置开始遍历。这个位置只能是较短链表的头结点位置。 为此，我们必须消除两个链表的长度差
         
            指针 pA 指向 A 链表，指针 pB 指向 B 链表，依次往后遍历
            如果 pA 到了末尾，则 pA = headB 继续遍历
            如果 pB 到了末尾，则 pB = headA 继续遍历
            比较长的链表指针指向较短链表head时，长度差就消除了
        如此，只需要将最短链表遍历两次即可找到位置

         */
        
        if headA == nil || headB == nil {
            return nil
        }
        var pA = headA
        var pB = headB
        
        while pA != pB {
            pA = (pA == nil) ? headB : pA?.next
            pB = (pB == nil) ? headA : pB?.next
        }
        return pA
    }
    class func getIntersectionNode2(_ headA : ListNode?, _ headB : ListNode?)->ListNode?{
        
        if headA == nil || headB == nil {
            return nil
        }
        var pA = headA
        var pB = headB
        
        var len1 = getNodeLength(headA)
        var len2 = getNodeLength(headB)
        while len1 < len2 {
            pB = pB?.next
            len2 -= 1
        }
        while len1 > len2 {
            pA = pA?.next
            len1 -= 1
        }
        while pA != pB {
            pA = pA?.next
            pB = pB?.next
        }
        return pA
    }
    private class func getNodeLength(_ head : ListNode?)->Int{
        var len = 0
        var head = head
        while head != nil {
            head = head?.next
            len += 1
        }
        return len
    }
    //MARK:-----------求众数
    class func majorityElement(_ nums : [Int])->Int{
        
        /*
         哈希表：O(n)
         */
        
        if nums.count == 0{
            return 0
        }
        let count = nums.count / 2
        var dic : [Int:Int] = [Int:Int]()
        for num in nums {
            if dic[num] == nil {
                dic[num]  = 1
            }else{
                dic[num] = dic[num]! + 1
            }
        }
        for (key, value) in dic {
            if value > count{
                return key
            }else{
                return 0
            }
        }
        return 0
    }
    class func majorityElement2(_ nums : [Int])->Int{
        
        /*
         排序：O(nlogn)
         
         如果所有数字被单调递增或者单调递减的顺序排了序，那么众数的下标为[n/2]（当n 是偶数时，下标为[n/2]+1
         */
        
        if nums.count == 0{
            return 0
        }
        let nums = nums.sorted()
        return nums[nums.count/2]
    }
    class func majorityElement3(_ nums : [Int])->Int{
        
        /*
         分治：O(nlogn)
         
         如果我们知道数组左边一半和右边一半的众数，我们就可以用线性时间知道全局的众数是哪个。
         使用经典的分治算法递归求解，直到所有的子问题都是长度为 1 的数组
         */
        return majorityElement(nums, 0, nums.count-1)
        
    }
    private class func majorityElement(_ nums : [Int], _ lo : Int, _ hi : Int)->Int{
        //如果数组只有一个元素
        if lo == hi{
            return nums[lo]
        }
        
        //递归求解左右两边的众数
        let mid = (hi-lo)/2 + lo
        var left = majorityElement(nums, lo, mid)
        var right = majorityElement(nums, mid+1, hi)
        
        if left == right {
            return left
        }
        
        //比较左右两边众数的次数，找出最大次数的即为数组的众数
        let leftCount = countInRange(nums, left, lo, hi)
        let rightCount = countInRange(nums, right, lo, hi)
        
        return leftCount > rightCount ? left : right
    }
    private class func countInRange(_ nums : [Int], _ num : Int, _ lo : Int, _ hi : Int)->Int{
        var count = 0
        for i in lo...hi {
            if nums[i] == num{
                count += 1
            }
        }
        return count
    }
    
    //MARK:-----------反转链表
    class func reverseList(_ head : ListNode?)->ListNode?{
        /*
         迭代：O(n)
         假设存在链表 1 → 2 → 3 → Ø，我们想要把它改成 Ø ← 1 ← 2 ← 3。
         
         在遍历列表时，将当前节点的 next 指针改为指向前一个元素。由于节点没有引用其上一个节点，因此必须事先存储其前一个元素。在更改引用之前，还需要另一个指针来存储下一个节点。不要忘记在最后返回新的头引用！
         */
        if head == nil {
            return nil
        }
        var curr = head
        var prev : ListNode? = nil
        while curr != nil {
            let nextTemp = curr?.next
            curr?.next = prev
            prev = curr
            curr = nextTemp
        }
        return prev
    }
    class func reverseList2(_ head : ListNode?)->ListNode?{
        /*
         递归：O(n)
         
         */
        if head == nil || head?.next == nil{
            return head
        }
        var p : ListNode? = reverseList2(head?.next)
        head?.next?.next = head
        head?.next = nil
        return p
    }
    //MARK:-----------数组中的第k个最大元素
    class func findKthLargest(_ nums : [Int], _ k : Int)->Int{
        /*
         排序，取出第k个元素
         
         最朴素的方法是先对数组进行排序，再返回倒数第 k 个元素
         */
        var nums = nums.sorted()
        return nums[nums.count-k]
    }
    class func findKthLargest1(_ nums : [Int], _ k : Int)->Int{
        /*
         快速选择 O(NlogN)。
         随机选择一个枢轴。
         使用划分算法将枢轴放在数组中的合适位置 pos。将小于枢轴的元素移到左边，大于等于枢轴的元素移到右边。
         比较 pos 和 N - k 以决定在哪边继续递归处理。
         */
//        return findKth(nums, k, 0, nums.count-1)
        var nums = nums
        let size = nums.count
        return quickselect(nums, 0, size-1, size-k)
    }
//    private class func findKth(_ nums : [Int], _ k : Int, _ start : Int, _ end : Int)->Int{
//        var copy = [Int].init(nums)
//        let mid = partition(&copy, start, end)
//        if mid == k-1 {
//            return copy[mid]
//        }else if mid < k-1{
//            return findKth(copy, k, mid+1,end)
//        }else{
//            return findKth(copy, k, start, mid-1)
//        }
//    }
//    private class func partition(_ nums : inout [Int], _ start : Int, _ end : Int)->Int{
//        guard start<=end, end<nums.count else {
//            return -1
//        }
//        let tmp = nums[start]
//        var start = start
//        var end = end
//        while start < end {
//            while start<end, nums[end] <= tmp{
//                end -= 1
//            }
//            nums[start] = nums[end]
//            while start<end, nums[start]>=tmp{
//                start += 1
//            }
//            nums[end] = nums[start]
//        }
//        nums[start] = tmp
//        return start
//    }
    private class func partition(_ nums : inout [Int], _ left : Int, _ right : Int, _ pivot_index : Int)->Int{
        let pivot = nums[pivot_index]
        //将基准元素移到末尾
        nums.swapAt(pivot_index, right)
        var store_index = left
        
        //将左右小于基准的元素移到左边
        for i in left...right{
            if nums[i] < pivot{
                nums.swapAt(store_index, i)
                store_index += 1
            }
        }
        
        //将基准移到最后
        nums.swapAt(store_index, right)
        return store_index
    }
    private class func quickselect(_ nums : [Int], _ left : Int, _ right : Int, _ k_smallest :Int)->Int{
        
        var nums = nums
        //返回第k个最小的元素
        //如果只有一个元素
        if left == right{
            return nums[left]
        }
        
        //选择一个随机的基准下标
        var pivot_index = left+Int.randomIntNumber(Range(0...(right-left)))
        pivot_index = partition(&nums, left, right, pivot_index)
        
        //如果第k个最大值等于基准下标
        if k_smallest == pivot_index {
            return nums[k_smallest]
        }else if k_smallest < pivot_index{
            //基准左边查找
            return quickselect(nums, left, pivot_index-1, k_smallest)
        }else{
            //基准右边查找
            return quickselect(nums, pivot_index+1, right, k_smallest)
        }
    }
    //MARK:-----------存在重复元素
    class func containsDuplicate(_ nums : [Int])->Bool{
        /*
         现行查找 O(n^2)
         循环不变式
         在下一次搜索之前,搜索过的整数中没有重复的整数。
         */
        for i in 0..<nums.count{
            for j in 0..<i {
                if nums[j] == nums[i] {
                    return true
                }
            }
        }
        return false
    }
    class func containsDuplicate1(_ nums : [Int])->Bool{
        /*
         哈希表
         时间复杂度为O(n)，
         */
        var arr : [Int] = [Int]()
        for num in nums {
            if arr.contains(num) {
                return true
            }else{
                arr.append(num)
            }
        }
        
        return false
    }
    class func containsDuplicate2(_ nums : [Int])->Bool{
        /*
         排序
         如果存在重复元素，排序后它们应该相邻。
         
         时间复杂度 : O(nlogn)。 排序的复杂度是O(nlogn)，扫描的复杂度是O(n)。整个算法主要由排序过程决定，因此是O(nlogn)。
         
         */
        var nums = nums.sorted()
        for i in 0..<nums.count-1 {
            if nums[i] == nums[i+1] {
                return true
            }
        }
        return false
    }
    //MARK:-----------二叉搜索树中第k小的元素
    private static var res = Int.max
    private static var count = 0
    class func kthSmallest(_ root : TreeNode?, _ k : Int)->Int{
        /*
         利用 二叉树在中序遍历后，得到的是有序数组，然后遍历到k个数即可
         步骤：
         1）二叉搜索树BST有一个重要性质：中序遍历为排序数组，根据这个性质，我们可将问题转化为寻找中序遍历第k个节点的值；
         2）实现的方法是建立两个全局变量res和count，分别用于存储答案与计数：
            在每次访问节点时，计数器-1；
            当count == 0时，代表已经到达第k个节点，此时记录答案至res；
         3）找到答案后，已经不用继续遍历，因此每次判断res是否为空，若不为空直接返回。

         */
        count = k
        inorder(root)
        return res
    }
    private class func inorder(_ root : TreeNode?){
        if root != nil{
            inorder(root?.left)
            if res != Int.max {
                return
            }
            count -= 1
            if count == 0{
                res = (root?.val)!
            }
            inorder(root?.right)
        }
    }
    class func kthSmallest2(_ root : TreeNode?, _ k : Int)->Int{
        /*
         模拟系统栈的方式：使用二叉树非递归遍历的通用方法
         */
        var list : [TreeNode?] = [TreeNode?]()
        var current  = root
        var k = k
        var ans : TreeNode? = nil
        while k > 0 {
            while current != nil{
                list.append(current)
                current = current?.left
            }
            ans = list.removeLast()
            current = ans?.right
            
            k = k-1
        }
        return (ans?.val)!
    }
    //MARK:-----------2的幂
    class func isPowerOfTwo(_ n : Int)->Bool{
        /*
         二进制：
         1、数字n若是2的次方，则一定满足以下条件：
            1）二进制表示下，n最高位为1，其余所有位为0；
            2）二进制表示下，n - 1最高位为0，其余所有位为1（除了n == 1的情况下，n - 1 == 0，即末位为最高位）；
            3）n <= 0时一定不是2的次方。
         2、因此，判断n > 0且n & (n - 1) == 0则可确定n是否是2的次方。
         */
        return n>0 && (n & (n-1) == 0)
    }
    class func isPowerOfTwo2(_ n : Int)->Bool{
        /*
         递归
         逐步增加除数的大小，每次增加为之前除数的2倍，如果除以除数为0，则除数重新置位2，以递归的方式重新计算
         */
        if n == 0 {
            return false
        }else{
            return cal(n)
        }
    }
    private class func cal(_ n : Int)->Bool{
        var n = n
        var div = 2
        while (n/div != 0) && (n%div == 0) {
            n = n / div
            div = div*2
        }
        if n%2 == 0 {
            return cal(n)
        }else if n == 1 {
            return true
        }else{
            return false
        }
    }
    //MARK:----------- 二叉搜索树的最近公共祖先
    class func lowestCommonAncestor(_ root : TreeNode?, _ p : TreeNode?, _ q : TreeNode?)->TreeNode?{
        /*
         二叉搜索树BST的性质：
         节点N 左子树上的所有节点的值都小于等于节点N 的值
         节点N 右子树上的所有节点的值都大于等于节点N 的值
         左子树和右子树也都是 BST
         
         递归 O(n)
         思路：节点p，q 的最近公共祖先（LCA）是距离这两个节点最近的公共祖先节点。在这里 最近 考虑的是节点的深度。
         算法：
         从根节点开始遍历树
         如果节点p 和节点q 都在右子树上，那么以右孩子为根节点继续 1 的操作
         如果节点p 和节点q 都在左子树上，那么以左孩子为根节点继续 1 的操作
         如果条件 2 和条件 3 都不成立，这就意味着我们已经找到节p 和节点q 的 LCA 了

         */
        let parentVal : Int = (root?.val)!
        let pVal : Int = (p?.val)!
        let qVal : Int = (q?.val)!
        
        if pVal > parentVal && qVal > parentVal {
            return lowestCommonAncestor(root?.right, p, q)
        }else if pVal < parentVal && qVal < parentVal{
            return lowestCommonAncestor(root?.left, p, q)
        }else{
            return root
        }
    }
    class func lowestCommonAncestor2(_ root : TreeNode?, _ p : TreeNode?, _ q : TreeNode?)->TreeNode?{
        /*
         迭代 O(n)
         用迭代的方法替代了递归来遍历整棵树
         */
        let pVal : Int = (p?.val)!
        let qVal : Int = (q?.val)!
        
        var node = root
        
        while node != nil {
            let parentVal : Int = (node?.val)!
            //如果节点p 和节点q 都在右子树上，那么以右孩子为根节点继续操作
            if pVal > parentVal && qVal > parentVal {
                return lowestCommonAncestor(root?.right, p, q)
            }else if pVal < parentVal && qVal < parentVal{
                //如果节点p 和节点q 都在左子树上，那么以左孩子为根节点继续操作
                return lowestCommonAncestor(root?.left, p, q)
            }else{
                return node
            }
        }
        return nil
    }
    //MARK:-----------
    //MARK:-----------
    //MARK:-----------
    //MARK:-----------
    //MARK:-----------
    //MARK:-----------
}
//MARK:-----------最小栈
/*
 106ms
 1、借用一个辅助栈min_stack，用于存储stack中最小值：
 push:每当push新值进来时，如果“小于等于”min_stack栈顶值，则一起push到min_stack，即更新了最小值；
 pop:判断pop出去的元素值是否是min_stack栈顶元素值（即最小值），如果是则将min_stack栈顶元素一起pop，这样可以保证min_stack栈顶元素始终是stack中的最小值。
 getMin:返回min_stack栈顶即可。
 2、min_stack的作用是对stack中的元素做标记，标记的原则是min_stack中元素一定是降序的（栈底最大栈顶最小）。换个角度理解，min_stack等价于遍历stack所有元素，把升序的数字都删除掉，留下一个从栈底到栈顶降序的栈。本题要求获取最小值的复杂度是O(1)，因此须构建辅助栈，在push与pop的过程中始终保持辅助栈为一个降序栈。
 3、时间空间复杂度都为O(N)，获取最小值复杂度为O(1)。
 */
class MinStack{
    var stack : IntegerStack
    var min_stack : IntegerStack
    
    init() {
        stack = IntegerStack()
        min_stack = IntegerStack()
    }
    
    public func push(_ x : Int){
        stack.push(x)
        if min_stack.isEmpty || x<=min_stack.peek! {
            min_stack.push(x)
        }
    }
    public func pop()->Int{
        if stack.pop() == min_stack.peek!{
            return min_stack.pop()!
        }
        return stack.pop()!
    }
    public func top()->Int{
        return stack.peek!
    }
    public func getMin()->Int{
        return min_stack.peek!
    }
}
class MinStack2{
    var stack : [Int]
    var min_stack : [Int]
    
    init() {
        stack = [Int]()
        min_stack = [Int]()
    }
    
    public func push(_ x : Int){
        stack.append(x)
        if min_stack.isEmpty || x<=min_stack.last! {
            min_stack.append(x)
        }
    }
    public func pop()->Int{
        if stack.popLast() == min_stack.last!{
            return min_stack.popLast()!
        }
        return stack.popLast()!
    }
    public func top()->Int{
        return stack.last!
    }
    public func getMin()->Int{
        return min_stack.last!
    }
}
//MARK:-----------栈的实现
protocol Stack {
    //持有元素的类型
    associatedtype Element
    //是否为空
    var isEmpty : Bool{get}
    //栈的大小
    var size : Int{get}
    //栈顶元素
    var peek : Element?{get}
    //进栈
    mutating func push(_ newElement : Element)
    //出栈
    mutating func pop()->Element?
}
//定义一个证书栈
struct IntegerStack:Stack {
    typealias Element = Int
    private var stack = [Element]()
    
    var isEmpty: Bool{
        return stack.isEmpty
    }
    
    var size: Int{
        return stack.count
    }
    
    var peek: Int?{
        return stack.last
    }
    
    mutating func push(_ newElement: Int) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Int? {
        return stack.popLast()
    }
    
    
    
    
}

//MARK:-----------双链表节点定义
public class Node{
    public var key : Int
    public var val : Int
    public var next, prev : Node?
    init(_ k : Int, _ v : Int) {
        self.key = k
        self.val = v
    }
}
//建立一个双链表
class DoubleList{
    //头尾虚节点
    var head, tail : Node?
    //链表元素数
    var size : Int = 0
    
    init() {
        head = Node(0, 0)
        tail = Node(0,0)
        head?.next = tail
        tail?.prev = head
        size = 0
    }
    //在链表头部添加节点x
    public func addFirst(_ x : Node){
        x.next = head?.next
        x.prev = head
        head?.next?.prev = x
        head?.next = x
        size += 1
    }
    //删除链表中的节点（x一定存在）
    public func remove(_ x : Node){
        x.prev?.next = x.next
        x.next?.prev = x.prev
        size -= 1
    }
    //删除链表最后一个节点，并返回该节点
    public func removeLast()->Node?{
        if tail?.prev?.val == (head?.val)! {
            return nil
        }
        let last = tail?.prev
        remove(last!)
        return last
    }
    //返回链表长度
    public func Size()->Int{
        return size
    }
}
//MARK:-----------LRU缓存机制
/*
 158ms
 LRU 缓存淘汰算法就是一种常用策略。LRU 的全称是 Least Recently Used，也就是说我们认为最近使用过的数据应该是是「有用的」，很久都没用过的数据应该是无用的，内存满了就优先删那些很久没用过的数据。
 
 思想：哈希表+双向链表
 */
class LRUCache{
    //哈希表
    var map : [Int:Node?] = [:]
    //双向链表
    var cache : DoubleList
    //最大容量
    var cap : Int
    
    init(_ capacity : Int) {
        self.cap = capacity
        self.map = [:]
        self.cache = DoubleList.init()
    }
    
    public func get(_ key : Int)->Int{
        if map[key] == nil {
            return -1
        }
        let val = (map[key] as? Node)!.val
        //利用put方法吧数据提前
        put(key,val)
        return val
    }
    public func put(_ key : Int, _ val : Int){
        //先把新节点x做出来
        let x = Node(key, val)
        
        if map[key] != nil{
            //删除旧节点
            cache.remove((map[key] as? Node)!)
            cache.addFirst(x)
            //更新map中的数据
            map[key] = x
        }else{
            if cap == cache.Size(){
                //删除链表最后一个节点
                let last = cache.removeLast()
                map.removeValue(forKey: (last?.key)!)
            }
            //直接添加到头部
            cache.addFirst(x)
            map[key] = x
        }
    }
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
extension ListNode : Equatable{
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        if lhs.val == rhs.val && lhs.next == rhs.next {
            return true
        }
        return false
    }
    
    
}
//MARK:-----------二叉树节点定义
public class TreeNode{
    public var val : Int
    public var left : TreeNode?
    public var right :TreeNode?
    public init(_ val : Int){
        self.val = val
        self.left = nil
        self.right = nil
    }
}

//MARK:-----------随机数
extension Int{
    /*这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    public static func randomIntNumber(_ lower : Int = 0, _ upper : Int = Int(UInt32.max))->Int{
        return lower + Int(arc4random_uniform(UInt32(upper-lower)))
    }
    //生成某个区间的随机数
    public static func randomIntNumber(_ range : Range<Int>)->Int{
        return randomIntNumber(range.lowerBound, range.upperBound)
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
    
    print("合并两个有序数组")
    var array1 = [1, 2, 3, 0, 0, 0]
    let array2 = [2, 5, 6]
//    Algorithm.merge(&array1, 3, array2, 3)
    Algorithm.merge1(&array1, 3, array2, 3)
//    Algorithm.merge2(&array1, 3, array2, 3)
    print("\n")
    
    print("格雷编码")
    print(Algorithm.grayCode(2))
    print(Algorithm.grayCode(3))
    print(Algorithm.grayCode1(2))
    print(Algorithm.grayCode1(3))
    print(Algorithm.grayCode2(2))
    print(Algorithm.grayCode2(3))
    print("\n")
    
    print("二叉树的最大深度")
    let treeN1 = TreeNode(3)
    let treeN2 = TreeNode(9)
    let treeN3 = TreeNode(20)
    let treeN4 = TreeNode(15)
    let treeN5 = TreeNode(7)
    treeN1.left = treeN2
    treeN1.right = treeN3
    treeN2.left = nil
    treeN2.right = nil
    treeN3.left = treeN4
    treeN3.right = treeN5
    treeN4.left = nil
    treeN4.right = nil
    treeN5.left = nil
    treeN5.right = nil
    print(Algorithm.maxDepth(treeN1))
    print(Algorithm.maxDepth1(treeN1))
    print("\n")
    
    print("买卖股票的最佳时机")
    print(Algorithm.maxProfit([7, 1, 5, 3, 6, 4]))
    print(Algorithm.maxProfit([7, 6, 4, 3, 1]))
    print(Algorithm.maxProfit1([7, 1, 5, 3, 6, 4]))
    print(Algorithm.maxProfit1([7, 6, 4, 3, 1]))
    print(Algorithm.maxProfit2([7, 1, 5, 3, 6, 4]))
    print(Algorithm.maxProfit2([7, 6, 4, 3, 1]))
    print("\n")
    
    print("买卖股票的最佳时机II")
    print(Algorithm.maxProfitII([7, 1, 5, 3, 6, 4]))
    print(Algorithm.maxProfitII([1, 2, 3, 4, 5]))
    print(Algorithm.maxProfitII2([7, 1, 5, 3, 6, 4]))
    print(Algorithm.maxProfitII2([1, 2, 3, 4, 5]))
    print(Algorithm.maxProfitII3([7, 1, 5, 3, 6, 4]))
    print(Algorithm.maxProfitII3([1, 2, 3, 4, 5]))
    print("\n")
    
    print("二叉树中的最大路径和")
    let treeN6 = TreeNode(-10)
    let treeN7 = TreeNode(9)
    let treeN8 = TreeNode(20)
    let treeN9 = TreeNode(15)
    let treeN10 = TreeNode(7)
    treeN6.left = treeN7
    treeN6.right = treeN8
    treeN7.left = nil
    treeN7.right = nil
    treeN8.left = treeN9
    treeN8.right = treeN10
    treeN9.left = nil
    treeN9.right = nil
    treeN10.left = nil
    treeN10.right = nil
    print(Algorithm.maxPathSum(treeN6))
    let treeN11 = TreeNode(1)
    let treeN12 = TreeNode(2)
    let treeN13 = TreeNode(3)
    treeN11.left = treeN12
    treeN11.right = treeN13
    print(Algorithm.maxPathSum(treeN11))
    print("\n")
    
    print("只出现一次的数字")
    print(Algorithm.singleNumber([2, 2, 1]))
    print(Algorithm.singleNumber([4, 1, 2, 1, 2]))
    print(Algorithm.singleNumber1([2, 2, 1]))
    print(Algorithm.singleNumber1([4, 1, 2, 1, 2]))
    print(Algorithm.singleNumber2([2, 2, 1]))
    print(Algorithm.singleNumber2([4, 1, 2, 1, 2]))
    print("\n")
    
    print("环形链表")
    let node17 = ListNode(3)
    let node18 = ListNode(2)
    let node19 = ListNode(0)
    let node20 = ListNode(-4)
    node17.next = node18
    node18.next = node19
    node19.next = node20
    node20.next = node18
    print(Algorithm.hasCycle(node17))
//    print(Algorithm.hasCycle2(node17))
    let node21 = ListNode(1)
    let node221 = ListNode(2)
    node21.next = node221
    node221.next = node21
    print(Algorithm.hasCycle(node21))
//    print(Algorithm.hasCycle2(node21))
    print("\n")
    
    print("环形链表II")
//    print(Algorithm.detectCycle(node17)?.val)
    print(Algorithm.detectCycle2(node17)?.val)
//    print(Algorithm.detectCycle(node21)?.val)
    print(Algorithm.detectCycle2(node21)?.val)
    print("\n")
    
    print("LRU缓存机制")
    let cache = LRUCache(2)
    cache.put(1, 1)
    cache.put(2, 2)
    print(cache.get(1))// 返回  1
    print(cache.map)
    cache.put(3, 3)// 该操作会使得密钥 2 作废
    print(cache.get(2))// 返回 -1 (未找到)
    print(cache.map)
    cache.put(4, 4)// 该操作会使得密钥 1 作废
    print(cache.get(1))// 返回 -1 (未找到)
    print(cache.get(3))// 返回  3
    print(cache.get(4))// 返回  4
    print(cache.map)
    print("\n")
    
    
    print("排序链表")
    let node222 = ListNode(4)
    let node223 = ListNode(2)
    let node224 = ListNode(1)
    let node225 = ListNode(3)
    node222.next = node223
    node223.next = node224
    node224.next = node225
    node225.next = nil
    var nodeHead222 = Algorithm.sortList(node222)
    var nodeHead222Arr = [Int]()
    while nodeHead222 != nil {
        nodeHead222Arr.append((nodeHead222?.val)!)
        nodeHead222 = nodeHead222?.next
    }
    print(nodeHead222Arr)
    let node226 = ListNode(-1)
    let node227 = ListNode(5)
    let node228 = ListNode(3)
    let node229 = ListNode(4)
    let node230 = ListNode(0)
    node226.next = node227
    node227.next = node228
    node228.next = node229
    node229.next = node230
    node230.next = nil
    var nodeHead226 = Algorithm.sortList(node226)
    var nodeHead226Arr = [Int]()
    while nodeHead226 != nil {
        nodeHead226Arr.append((nodeHead226?.val)!)
        nodeHead226 = nodeHead226?.next
    }
    print(nodeHead226Arr)
    print("\n")
    
    print("最小栈")
    let minStack = MinStack.init()
    minStack.push(-2)
    minStack.push(0)
    minStack.push(-3)
    print(minStack.getMin())//--> 返回 -3.
    minStack.pop()
    print(minStack.top())//--> 返回 0.
    print(minStack.getMin())//--> 返回 -2.
    let minStack2 = MinStack2.init()
    minStack2.push(-2)
    minStack2.push(0)
    minStack2.push(-3)
    print(minStack2.getMin())//--> 返回 -3.
    minStack2.pop()
    print(minStack2.top())//--> 返回 0.
    print(minStack2.getMin())//--> 返回 -2.
    print("\n")
    
    print("相交链表")
    let node231 = ListNode(4)//链表A
    let node232 = ListNode(2)
    let node233 = ListNode(8)
    let node234 = ListNode(4)
    let node235 = ListNode(5)
    let node236 = ListNode(5)//链表B
    let node237 = ListNode(0)
    let node238 = ListNode(1)
    node231.next = node232
    node232.next = node233
    node233.next = node234
    node234.next = node235
    node235.next = nil
    node236.next = node237
    node237.next = node238
    node238.next = node233
    print(Algorithm.getIntersectionNode(node231, node236)?.val)
//    print(Algorithm.getIntersectionNode2(node231, node236)?.val)
    print("\n")
    
    print("求众数")
    print(Algorithm.majorityElement([3, 2, 3]))
    print(Algorithm.majorityElement([2, 2, 1, 1, 1, 2, 2]))
    print(Algorithm.majorityElement2([3, 2, 3]))
    print(Algorithm.majorityElement2([2, 2, 1, 1, 1, 2, 2]))
    print(Algorithm.majorityElement3([3, 2, 3]))
    print(Algorithm.majorityElement3([2, 2, 1, 1, 1, 2, 2]))
    print("\n")
    
    print("反转链表")
    let node239 = ListNode(1)
    let node240 = ListNode(2)
    let node241 = ListNode(3)
    let node242 = ListNode(4)
    let node243 = ListNode(5)
    node239.next = node240
    node240.next = node241
    node241.next = node242
    node242.next = node243
    node243.next = nil
//    var head243 = Algorithm.reverseList(node239)
    var head243 = Algorithm.reverseList2(node239)
    var arr243 = [Int]()
    while head243 != nil {
        arr243.append((head243?.val)!)
        head243 = head243?.next
    }
    print(arr243)
    print("\n")
    
    print("数组中的第k个最大元素")
    print(Algorithm.findKthLargest([3, 2, 1, 5, 6, 4], 2))
    print(Algorithm.findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))
    print(Algorithm.findKthLargest1([3, 2, 1, 5, 6, 4], 2))
    print(Algorithm.findKthLargest1([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))
    print("\n")
    
    print("存在重复元素")
    print(Algorithm.containsDuplicate([1, 2, 3, 1]))
    print(Algorithm.containsDuplicate([1, 2, 3, 4]))
    print(Algorithm.containsDuplicate([1, 1, 1, 3, 3, 4, 3, 2, 4, 2]))
    print(Algorithm.containsDuplicate1([1, 2, 3, 1]))
    print(Algorithm.containsDuplicate1([1, 2, 3, 4]))
    print(Algorithm.containsDuplicate1([1, 1, 1, 3, 3, 4, 3, 2, 4, 2]))
    print(Algorithm.containsDuplicate2([1, 2, 3, 1]))
    print(Algorithm.containsDuplicate2([1, 2, 3, 4]))
    print(Algorithm.containsDuplicate2([1, 1, 1, 3, 3, 4, 3, 2, 4, 2]))
    print("\n")
    
    print("二叉搜索树中第k小的元素")
    let treeN14 = TreeNode(3)
    let treeN15 = TreeNode(1)
    let treeN16 = TreeNode(4)
    let treeN17 = TreeNode(2)
    treeN14.left = treeN15
    treeN14.right = treeN16
    treeN15.right = treeN17
    print(Algorithm.kthSmallest(treeN14, 1))
    print(Algorithm.kthSmallest2(treeN14, 1))
    let treeN18 = TreeNode(5)
    let treeN19 = TreeNode(3)
    let treeN20 = TreeNode(6)
    let treeN21 = TreeNode(2)
    let treeN22 = TreeNode(4)
    let treeN23 = TreeNode(1)
    treeN18.left = treeN19
    treeN18.right = treeN20
    treeN19.left = treeN21
    treeN19.right = treeN22
    treeN21.left = treeN23
//    print(Algorithm.kthSmallest(treeN18, 3))
    print(Algorithm.kthSmallest2(treeN18, 3))
    print("\n")
    
    print("2的幂")
    print(Algorithm.isPowerOfTwo(1))
    print(Algorithm.isPowerOfTwo(16))
    print(Algorithm.isPowerOfTwo(218))
    print(Algorithm.isPowerOfTwo2(1))
    print(Algorithm.isPowerOfTwo2(16))
    print(Algorithm.isPowerOfTwo2(218))
    print("\n")
    
    print("二叉搜索树的最近公共祖先")
    let treeN24 = TreeNode(6)
    let treeN25 = TreeNode(2)
    let treeN26 = TreeNode(8)
    let treeN27 = TreeNode(0)
    let treeN28 = TreeNode(4)
    let treeN29 = TreeNode(7)
    let treeN30 = TreeNode(9)
    let treeN31 = TreeNode(3)
    let treeN32 = TreeNode(5)
    treeN24.left = treeN25
    treeN24.right = treeN26
    treeN25.left = treeN27
    treeN25.right = treeN28
    treeN26.left = treeN29
    treeN26.right = treeN30
    treeN28.left = treeN31
    treeN28.right = treeN32
    print(Algorithm.lowestCommonAncestor(treeN24, treeN25, treeN26)?.val)
    print(Algorithm.lowestCommonAncestor(treeN24, treeN25, treeN28)?.val)
    print(Algorithm.lowestCommonAncestor2(treeN24, treeN25, treeN26)?.val)
    print(Algorithm.lowestCommonAncestor2(treeN24, treeN25, treeN28)?.val)
    print("\n")
}
