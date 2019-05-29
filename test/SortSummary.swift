//
//  SortSummary.swift
//  test
//
//  Created by Jialin Chen on 2019/5/27.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import Foundation

class SortSummary{
    //MARK:----------冒泡排序------------
    //冒泡
    /*
     时间复杂度：
     1、最好的情况下 即待排序的数组本身是有序的，比较次数为n-1，没有数据交换，即O(n)
     2、最坏的情况下 即待排序的数组是完全逆序的，比较次数为n*(n-1)/2，即O(n^2)
     思想：不断比较两个相邻的元素，如果它们的顺序不符合要求就互换位置
     1、比较相邻的元素，如果第一个比第二个大，就交换两个数，直到把最大的元素放到数组尾部
     2、遍历长素-1，对剩下的元素重复1的操作，直到没有任何一对数字需要比较时完成
     */
    class func bubbleSort(_ array : [Int]){
        var list = array
        //记录循环次数
        var count = 0
        for i in 0..<list.count {
            count = i
            for j in i+1..<list.count{
                if list[i] > list [j] {
//                    let tmp = list[j]
//                    list[j] = list[i]
//                    list[i] = tmp
                    list.swapAt(i, j)
//                    swap(&list[i], &list[j])
//                    (list[i], list[j]) = (list[j], list[i])
                }
            }
        }
        print(list)
        print("count: ",count)
    }
    //冒泡优化1----外层优化：当发现在某一趟排序中没有发生交换，则说明排序已经完成，所以可以在此趟排序后结束排序，在每趟排序前设置flag，当其未发生变化时，终止算法
    class func bubbleSort1(_ array : [Int]){
        var list = array
        //记录循环次数
        var count = 0
        for i in 0..<list.count {
            var flag = true
            count = i
            for j in i+1..<list.count{
                if list[i] > list [j] {
//                    let tmp = list[j]
//                    list[j] = list[i]
//                    list[i] = tmp
                    list.swapAt(i, j)
                    //                    (list[i], list[j]) = (list[j], list[i])
                    flag = false
                }
            }
            if flag {
                break
            }
        }
        print(list)
        print("count: ",count)
        
    }
    
    //冒泡优化2---内层优化：每趟排序中，最后一次发生交换的位置后面的数据均以有序，所以可以记住最后一次交换的位置来减少排序的趟数
    class func bubbleSort2(_ array : [Int]){
        var list = array
        //swap变量用来标记循环里最后一次交换的位置
        var swap = 0
        var k = list.count - 1
        //记录循环次数
        var count = 0
        for i in 0..<list.count {
            var flag = true
            count = i
            for j in 0..<k{
                if list[j] > list [j+1] {
                    //                    let tmp = list[j]
                    //                    list[j] = list[i]
                    //                    list[i] = tmp
                    list.swapAt(j, j+1)
                    //                    (list[i], list[j]) = (list[j], list[i])
                    flag = false
                    swap = j
                }
            }
            k = swap
            if flag {
                break
            }
        }
        print(list)
        print("count: ",count)
        
    }
    
    //MARK:----------选择排序------------
    //选择
    /*
     时间复杂度：无论最好还是最坏情况下，比较次数都是n*(n-1)/2，即 O(n^2)
     思想：通过n-i次关键字之间的比较，从n-i+1个记录中选出关键字最小的记录，并和第i个记录做交换
     1、在未排序的序列中找到最小/大的元素，存放到排序序列的起始位置，
     2、然后再继续从剩余未排序的元素中继续寻找最小/大元素，放到已排序序列的末尾，
     3、以此类推，知道所有元素均排序
     */
    
    class func chooseSort(_ array : [Int]){
        var list = array
        var count = 0
        for i in 0..<list.count {
            //记录当前最小的数，比较i+1后更大的数进行记录
            var min = i
            count = i
            for j in i+1..<list.count{
                if list[j]<list[min]{
                    min = j
                }
            }
            list.swapAt(i, min)
        }
        print(list)
        print("count: ",count)
    }
    
    //MARK:----------插入排序------------
    //插入
    /*
     时间复杂度：
     1、最好的情况下，完全没有任何数据移动，即O(n)
     2、最坏的情况下(平均性能表现)，比较的次数为(n+2)*(n+1)/2,移动的次数最大值(n+4)*(n-1)/2, 即O(n^2)
     思想：通过构建有序序列，对于未排序数据，在已排序序列中从后往前扫描，找到相应位置并插入
     1、从第一个元素开始，该元素可以认为已经被排序
     2、取出下一个元素，在已经排序的元素序列中从后向前扫描
     3、如果该元素（已排序）大于新元素，将该元素移到下一位置
     4、重复3，知道找到已排序的元素小于或等于新元素的位置
     5、将新元素插入到该位置
     6、重复2～5
     */
    class func insertSort(_ array : [Int]){
        var list = array
        //建立一个空数组，符合条件的插入，没插入的尾后添加
        var newList = [list[0]]
        
        var count = 0
        for i in 1..<list.count {
//            var max : Int? = nil //从大到小排序
            var min : Int? = nil//从小到大排序
            count = i
            for j in 0..<newList.count {
//                if list[i] > newList[j] {
//                    max = i
                if list[i] < newList[j] {
                    min = i
                    newList.insert(list[i], at: j)
                    break
                }
                
            }
//            if max == nil {
//                newList.append(list[i])
//            }
            if min == nil {
                newList.append(list[i])
            }
        }
        print(newList)
        print("count: ",count)
    }
    
    //插入排序，通过交换
    class func insertSort1(_ array : [Int]){
        var list = array
        var count = 0
        for i in 1..<list.count {
            //从i往前找，符合条件交换
            var y = i
            count = i
            //从大到小排序
//            while y>0 && list[y]>list[y-1]{
//                list.swapAt(y, y-1)
//                y -= 1
//            }
            //从小到大排序
            while y>0 && list[y]<list[y-1]{
                list.swapAt(y, y-1)
                y -= 1
            }
        }
        print(list)
        print("count: ",count)
    }
    
    //插入排序，通过移动
    class func insertSort2(_ array : [Int]){
        var list = array
        var count = 0
        for i in 1..<list.count {
            count = i
            //从i往前找，符合条件移动
            var y = i
            let tmp = list[y]
            //从大到小排序
//            while y>0 && tmp>list[y-1]{
//                list[y] = list[y-1]
//                y -= 1
//            }
            //从小到大排序
            while y>0 && tmp<list[y-1]{
                list[y] = list[y-1]
                y -= 1
            }
            list[y] = tmp
        }
        print(list)
        print("count: ",count)
    }
    //插入排序通用化
    class func insertSort3<T>(_ array : [T], _ isOrderedBefore:(T, T)->Bool)->[T]{
        var list = array
        var count = 0
        for i in 1..<list.count {
            count = i
            //从i往前找，符合条件移动
            var y = i
            let tmp = list[y]
            //从大到小排序
            //            while y>0 && tmp>list[y-1]{
            //                list[y] = list[y-1]
            //                y -= 1
            //            }
            //从小到大排序
            while y>0 && isOrderedBefore(tmp, list[y-1]){
                list[y] = list[y-1]
                y -= 1
            }
            list[y] = tmp
        }
        print(list)
        print("count: ",count)
        return list
    }
    
    //MARK:----------堆排序------------
    //堆排序----不稳定
    /*
     时间复杂度：
     1、在构建堆的过程中，由于是是完全二叉树从最下层最右边非终端节点开始构建，将它与子节点进行比较，对于每个非终端节点而言，最多进行两次比较和交换操作，因此构建堆的时间复杂度为O(n)
     2、在整个排序过程中，第 i 次去堆顶记录重建堆需要时间为logi ,并且需要取 n - 1次堆记录，所以重建堆的时间复杂度为O(nlogn)。
     3、堆的时间复杂度为O(nlogn)
     思想：利用堆这种数据结构所设计的一种排序算法，堆事一个近似完全二叉树的结构，并同时满足堆性质--即子结点的键值或索引总是小于/大于他的父结点
     1、最大堆调整Max_Heapify：将堆的末端子节点作调整，使得子结点永远小于父结点---》保持最大堆的性质，是创建最大堆的核心子程序
     2、创建最大堆Build_Max_Heap：将堆所有数据重新排序---》将一个数组改造成最大堆，接受数组和堆大小两个参数，Build-Max-Heap 将自下而上的调用 Max-Heapify 来改造数组，建立最大堆
     3、堆排序HeapSort：移除位在第一个数据的根节点，并做最大堆调整的递归运算
     */
    /*
     堆是通过数组实现的:
     1、父结点i的左子节点的位置---(2*i+1)
     2、父结点i的右子节点的位置---(2*i+2)
     3、子结点i的父结点的位置---floor((i-1)/2)  floor函数的作用是向下取整
     
     从小到大的排序思路：把一堆数字调整成大顶堆->堆顶元素和末尾元素交换->去掉末尾元素，继续大顶堆调整->重复以上动作
     */
    class func heapSort(_ array : inout Array<Int>){
        //1、构建大顶堆
        
        //从二叉树的一边的最后一个结点开始
        for i in (0...(array.count/2-1)).reversed() {
            //从第一个非叶子结点从下至上，从右至左调整结构
            SortSummary.adjustHeap(&array, i, array.count)
        }
        //2、调整堆结构+交换堆顶元素与末尾元素
        for j in (1...(array.count-1)).reversed() {
            //将堆顶元素与末尾元素进行交换
            array.swapAt(0, j)
            //重新对堆进行调整
            SortSummary.adjustHeap(&array, 0, j)
        }
    }
    //调整大顶堆（仅是调整过程，建立在大顶堆以构建的基础上）
    private class func adjustHeap(_ array : inout Array<Int>, _ i : Int, _ length : Int){
        var i = i
        //取出当前元素i
        let tmp = array[i]
        var k = 2*i+1
        //从i结点的左子节点开始，也就是2i+1处开始
        while k < length {
            //如果左子节点小于右子节点，k指向右子节点
            if k+1<length && array[k]<array[k+1]{
                k += 1
            }
            //如果子节点大于父结点，将子节点值赋给父结点，不用进行交换
            if array[k]>tmp {
                array[i] = array[k]
                //记录当前结点
                i = k
            }else{
                break
            }
            //下一个结点
            k = k*2+1
        }
        //将tmp值放到最终的位置
        array[i] = tmp
    }
    
    //MARK:----------归并排序------------
    //归并排序
    /*
     时间复杂度：
     思想：分而治之，即将一个大问题分解成较小的问题并解决他们，可以分为 先拆分 和 后合并
     1、将数字放在未排序的堆中
     2、将堆分成两部分，即两个未排序的数字堆
     3、继续分裂 两个未排序的数字堆，知道不能分裂为止，最后，你将拥有 n 个堆，每个堆中有一个数字
     4、通过顺序配对，开始合并堆，在每次合并期间，将内容按排序顺序排列
     */
    //自上而下的实施----递归法
    class func mergeSort(_ array: [Int])->[Int]{
        //1、如果数组为空或包含单个元素，则无法将其拆分为更小的部分，返回数组就行
        guard array.count > 1 else{
            return array
        }
        //2、找到中间索引
        let middleIndex = array.count/2
        
        //3、使用上一步中的中间索引，递归的分割数组的左侧
        let leftArray = mergeSort(Array(array[0..<middleIndex]))
        
        //4、递归的分割数组的右侧
        let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
        
        //5、将所有值合并在一起，确保它始终排序
        return SortSummary.merge(leftArray, rightArray)
    }
    //合并算法
    private class func merge(_ leftPile : [Int], _ rightPile : [Int])->[Int]{
        //1、合并时需要两个索引来跟踪两个数组的进度
        var leftIndex = 0
        var rightIndex = 0
        
        //2、合并后的数组，目前时空的，需要在下面的操作中添加其他数组中的元素构建
        var orderedPile = [Int]()
        
        //3、while循环将比较左侧和右侧的元素，并添加到orderpile。同时确保结果保持有序
        while leftIndex<leftPile.count && rightIndex<rightPile.count {
            if leftPile[leftIndex] < rightPile[rightIndex]{
                orderedPile.append(leftPile[leftIndex])
                leftIndex += 1
            }else if leftPile[leftIndex]>rightPile[rightIndex]{
                orderedPile.append(rightPile[rightIndex])
                rightIndex += 1
            }else{
                orderedPile.append(leftPile[leftIndex])
                leftIndex += 1
                orderedPile.append(rightPile[rightIndex])
                rightIndex += 1
            }
        }
        
        //4、如果前一个while循环完成，意味着left/right中的一个内容已经完全合并到orderpile中，不需要再比较，只需要依次添加剩下的数组的剩余元素
        while leftIndex < leftPile.count {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < rightPile.count {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
        
        return orderedPile
    }
    //自下而上的实施----迭代（排序数组时，跳过拆分步骤并立即开始合并各个数组元素）
    //最佳，最差和平均情况的时间复杂度将始终为 O(n log n)。
    class func mergeSortBottomUp<T>(_ array : [T], _ isOrderedBefore:(T, T)->Bool)->[T]{
        let n = array.count
        
        //1、归并排序需要一个临时工作数组，因为不能再原数组合并同时又覆盖原有内容---使用两个数组，将使用d的值在他们之前切换，它是0/1，数组 z[d] 用于读，数组 z[1-d] 用于写，称为双缓冲
        var z = [array, array]
        var d = 0
        
        //2、自下而上与x自上而下工作方式相同，都是先合并每个元素的小堆，在合并每个堆两个元素---堆的大小由 width 给出，width初始是1，但在每次迭代结束时，width *2，所以外循环确定合并的堆的大小
        var width = 1
        while width < n {
            var i = 0
            //3、内循环穿过堆并将每对堆合并成一个较大堆，结果写入z[1-d]给出的数组中
            while i < n{
                var j = i
                var left = i
                var right = i+width
                
                let lmax = min(left+width, n)
                let rmax = min(right+width, n)
                
                //4、与自下而上逻辑相同，区别在于自上而下使用双缓冲，从z[d]读 并写入 z[1-d],还是用isOrderedBefore函数来比较元素，是通用的
                while left < lmax && right < rmax{
                    if isOrderedBefore(z[d][left], z[d][right]) {
                        z[1-d][j] = z[d][left]
                        left += 1
                    }else{
                        z[1-d][j] = z[d][right]
                        right += 1
                    }
                    j += 1
                }
                while left<lmax {
                    z[1-d][j] = z[d][left]
                    j += 1
                    left += 1
                }
                while right < rmax {
                    z[1-d][j] = z[d][right]
                    j += 1
                    right += 1
                }
                i += width*2
            }
            width *= 2
            
            //5、z[d]的大小width 的堆已经合并为数组z[1-d]中更大的大小width*2，这里 交换活动数组，方便在下一步中我们从刚刚创建的新堆中读取
            d = 1-d
        }
        return z[d]
    }
    
    //MARK:----------快速排序------------
    //快速排序---不稳定排序
    /*
     时间复杂度：
     1、最差的情况，递归调用n次，空间复杂度为O(n)，需要O(n^2)次比较 即 O(n^2)
     2、最好的情况，递归调用logn次，空间复杂度O(logn)，即 O(nlogn)
     思想：对冒泡排序的一种改进，通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列
     实现从大到小排序，快排思想：从左向右查找，比基准小的交换到右边区域，从右往左查找，比基准大的交换到左边区域
     1、从数列中跳出一个元素，作为 基准pivot
     2、重新排序数列，所有比基准小的放在基准前，所有比基准大的放在基准后（相同的数可以任意一边）在这个分区退出后，该基准就处于数列的中间位置，称为分区partition操作
     3、递归recursive的把小于基准值的子数列和大于基准值的子数列排序
     */
    class func quickSort(_ array : inout [Int], _ low : Int, _ high : Int){
        if low >= high {
            return
        }
        var i = low
        var j = high
        
        //基准值
        let point = array[i]
        while i<j {
            //从右边开始找，要是找到右边有比point小的，交换他们的位置
            //下面的循环，当找到array[i]<point时结束
            while i<j && array[j]>=point{
                j -= 1
            }
            //循环结束，也就是找到array[j]<point，交换他们的位置
            array[i] = array[j]
            
            //2 从左开始找，此时是i增加，当找到array[i]>point时交换他们的位置
            while i<j && array[i]<=point{
                i += 1
            }
            array[j] = array[i]
        }
        
        //每一次排序比较完成后基准数的位置，按这个位置切分数组
        array[i] = point
        
        //递归处理基准左右的子数列
        quickSort(&array, low, i-1)
        quickSort(&array, i+1, high)
        
    }
    
    //MARK:----------希尔排序------------
    //希尔排序---递减增量排序算法，是插入排序的高效改进版本，非稳定排序算法
    /*
     时间复杂度：
     1、当增量为1时，希尔直接退化成了直接插入排序，为O(n^2)
     2、hibbard增量的希尔排序，为O(n^3/2)
     思想：元素通过每次移动较大间隙，整个数组可以快速形成局部排序好的情况，这样会让接下来的交换变的更加l快速，因为元素之间不需要进行过多次的位置交换
     1、希尔排序是把记录按下标的一定增量分组，对每组使用直接插入排序算法排序
     2、随着增量逐渐减少，每组包含的关键词越来越多，当增量减至1时，整个文件x恰被分成一组，算法便终止
     
     以n=10的一个数组49, 38, 65, 97, 26, 13, 27, 49, 55, 4为例
     第一次增量 gap = 10 / 2 = 5
     49   38   65   97   26   13   27   49   55   4
     
     1A                       1B
     
          2A                       2B
     
               3A                       3B
     
                    4A                       4B
     
                         5A                       5B
     
     1A,1B，2A,2B等为分组标记，数字相同的表示在同一组，大写字母表示是该组的第几个元素， 每次对同一组的数据进行直接插入排序。即分成了五组(49, 13) (38, 27) (65, 49)  (97, 55)  (26, 4)这样每组排序后就变成了(13, 49)  (27, 38)  (49, 65)  (55, 97)  (4, 26)，下同。
     第二次增量 gap = 5 / 2 = 2
     13   27   49   55   4    49   38   65   97   26
     
     1A        1B        1C        1D        1E
     
        2A        2B        2C        2D        2E
     
     第三次增量 gap = 2 / 2 = 1
     4   26   13   27   38    49   49   55   97   65
     
     1A  1B   1C   1D   1E    1F   1G   1H   1I   1J
     
     第四次增量 gap = 1 / 2 = 0 排序完成得到数组：
     4   13   26   27   38    49   49   55   65   97
     
     */
    class func shellSort(_ array : inout [Int]){
        var j : Int
        //获取增量
        var gap = array.count/2
        
        while gap > 0 {
            for i in 0..<gap{
                j = i+gap
                while j < array.count {
                    if array[j] < array[j-gap]{
                        let tmp = array[j]
                        var k = j - gap
                        //插入排序
                        while k>=0 && array[k]>tmp {
                            array[k+gap] = array[k]
                            k -= gap
                        }
                        array[k+gap] = tmp
                    }
                    j += gap
                }
            }
            //增量减半
            gap /= 2
        }
    }
    
    //MARK:----------桶排序------------
    //桶排序
    /*
     时间复杂度：O(n)
     思想：将数组分到有限数量的桶里，然后寻访序列，并且把项目一个一个放到对应的桶子去，对每个不是空的桶子进行排序，最终将所有的桶合并
     1、建桶
     2、分桶
     3、小桶排序
     */    
    class func bucketSort(_ array : [Int], _ max : Int)->[Int]{
        var a : [Int] = [Int].init(repeating: 0, count: max)
        
        //1、创建一个空桶，全部存0
        for i in 0..<max {
            a[i] = 0
        }
        
        //2、将数组中的元素作为a的下标存储，如果有相同的，则+1
        for num in array {
            var index = NSInteger(num)
            if a[index] as! NSInteger >= 0{
                a[index] = (a[index] as! NSInteger)+1
            }else{
                a[index] = 0
            }
        }
        
        //遍历桶，根据下标取出数据并排序
        var sort = [Int]()
        for i in 0..<a.count {
            if a[i] as! NSInteger > 0 {
                if a[i] as! NSInteger > 1{
                    //处理相同数据的情况
                    for _ in 0..<a[i]{
                        sort.append(i)
                    }
                }else{
                    sort.append(i)
                }
                
            }
        }
        
        return sort
    }
    
    //MARK:----------排序实战------------
    /*
     Facebook, Google, Linkedin都考过的面试题。
     
     已知有很多会议，如果有这些会议时间有重叠，则将它们合并。
     比如有一个会议的时间为3点到5点，另一个会议时间为4点到6点，那么合并之后的会议时间为3点到6点
     
     基本思路：遍历一次数组，然后归并所有重叠时间，将数组按照会议开始的时间排序
     */
    class func meetingTimeMerge(_ meetingTimes : [MeetingTime])->[MeetingTime]{
        var meetingTimes = meetingTimes
       //处理特殊情况
        guard meetingTimes.count > 1 else {
            return meetingTimes
        }
        
        //排序
        var meetingSort = meetingTimes.sort(){
            if $0.start != $1.start {
                return $0.start < $1.start
            }else{
                return $0.end < $1.end
            }
        }
        
        //新建结果数组
        var res = [MeetingTime]()
        res.append(meetingTimes[0])
        
        //遍历排序后的数组，并与结果数组归并
        for i in 1..<meetingTimes.count {
            let last = res[res.count-1]
            let current = meetingTimes[i]
            if current.start > last.end {
                res.append(current)
            }else{
                last.end = max(last.end, current.end)
            }
        }
        return res
    }
}


//定义会议的类
public class MeetingTime{
    public var start : Int
    public var end : Int
    public init(_ start : Int, _ end : Int){
        self.start = start
        self.end = end
    }
}
