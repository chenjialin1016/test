//
//  SortSummary.swift
//  test
//
//  Created by  on 2019/5/27.
//  Copyright © 2019年 . All rights reserved.
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
    class func bubbleSort(_ array : [Int])->[Int]{
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
         return list
    }
    //冒泡优化1----外层优化：当发现在某一趟排序中没有发生交换，则说明排序已经完成，所以可以在此趟排序后结束排序，在每趟排序前设置flag，当其未发生变化时，终止算法
    class func bubbleSort1(_ array : [Int])->[Int]{
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
         return list
        
    }
    
    //冒泡优化2---内层优化：每趟排序中，最后一次发生交换的位置后面的数据均以有序，所以可以记住最后一次交换的位置来减少排序的趟数
    class func bubbleSort2(_ array : [Int])->[Int]{
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
         return list
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
    /** 选择排序算法思想
     
     *  每一趟从前往后查找出值最小的索引（下标），最后通过比较是否需要交换。每一趟都将最小的元素交换到最前面。
     
     *  大致过程
     
     *  6, 4, 9, 7, 5（开始）
     
     *  4, 6, 9, 7, 5（第一趟：将最小的4与6交换，使这一趟最小值4放到最前面）
     
     *  4, 5, 9, 7, 6（第二趟：将最小的5与6交换，使这一趟最小值5放到最前面）
     
     *  4, 5, 6, 7, 9（第三趟：将最小的6与9交换，使这一趟最小值6放到最前面）
     
     *  4, 5, 6, 7, 9（第四趟：不需要交换，排序完成）
     
     */
    class func chooseSort(_ array : [Int])->[Int]{
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
         return list
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
    class func insertSort(_ array : [Int])->[Int]{
        var list = array
        //建立一个空数组，符合条件的插入，没插入的尾后添加
        var newList = [list[0]]
        //记录循环的次数
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
         return newList
    }
    
    //插入排序，通过交换
    class func insertSort1(_ array : [Int])->[Int]{
        var list = array
        //记录循环次数
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
        return list
    }
    
    //插入排序，通过移动
    class func insertSort2(_ array : [Int])->[Int]{
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
        return list
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
    
    //非递归
    class func mergeSort1(_ array: [Int])->[Int]{
        //1、如果数组为空或包含单个元素，则无法将其拆分为更小的部分，返回数组就行
        guard array.count > 1 else{
            return array
        }
        
        //2、将数组中的每一个元素放入一个数组中
        var tampArr : [[Int]] = []
        for item in array {
            var subArr : [Int] = []
            subArr.append(item)
            tampArr.append(subArr)
        }
        
        //3、对数组中的数组进行合并，直到合并完成为止
        while tampArr.count != 1 {
            print(tampArr)
            var i = 0
            while i < tampArr.count-1 {
                tampArr[i] = merge(tampArr[i], tampArr[i+1])
                tampArr.remove(at: i+1)
                i += 1
            }
        }
        return tampArr.first!
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
    /** 快速排序的算法思想
     
     *  一趟快速排序的算法是：
     
     *   1、设置两个变量i、j，排序开始的时候：i=0，j=N-1；
     
     *   2、以第一个数组元素作为基准数据，赋值给point，即point=A[0]；
     
     *   3、从j开始向前搜索，即由后开始向前搜索(j减1)，找到第一个小于point的值A[j]，将A[j]和A[i]互换；
     
     *   4、从i开始向后搜索，即由前开始向后搜索(i++)，找到第一个大于point的A[i]，将A[i]和A[j]互换；
     
     *   5、重复第3、4步，直到i=j； (3,4步中，没找到符合条件的值，即3中A[j]不小于key,4中A[i]不大于key的时候改变j、i的值，
     
     *     使得j=j-1，i=i+1，直至找到为止。找到符合条件的值，进行交换的时候i， j指针位置不变。
     
     *     另外，i==j这一过程一定正好是i+或j-完成的时候，此时令循环结束）。
     
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
    
    //MARK:----------基数排序------------
    //基数排序---利用桶来实现的
    /*
     时间复杂度：基数排序的时间复杂度为O(d(n+radix))，其中，一趟分配时间复杂度为O(n)，一趟收集时间复杂度为O(radix)，共进行d趟分配和收集
     思想：利用桶来实现的
     1、以无序序列数值的个数为基数，将无序序列的值进入到基数对应的桶中
     2、个位数为基数入桶完毕后，在安装编号从小到大将桶中的数据以此取出，再存入之前的数组中
     3、在2中生成的数组的基础上再以式位数为基准入桶，入桶完毕后，再次按照桶的编号顺序将数值取出
     4、排序的数值越大，入桶出桶的次数就越多，所以随着位数的增大，效率会降低
     */
    //1、创建n个空桶
    /*
     返回结果的类型是Array<Array<Int>>，是一个二维数组。
     内层数组就是一个桶，负责存放与该桶编号相等的基数对应的数值
     */
    private class func createBucket(_ n : Int)->Array<Array<Int>>{
        var bucket : Array<Array<Int>> = []
        for _ in 0..<n {
            bucket.append([])
        }
        return bucket
    }
    //2、计算无序序列中最大的那个数
    /*
     取基数入桶出桶的次数以此最大数值的位数为准
     */
    private class func listMaxItem(_ list : Array<Int>)->Int{
        var maxNumber = list[0]
        for item in list {
            if maxNumber < item {
                maxNumber = item
            }
        }
        return maxNumber
    }
    //3、获取数字的长度----即取基数的次数
    private class func numberLength(_ num : Int)->Int{
        return "\(num)".count
    }
    //4、获取数值中特定位数的值
    /*
     通过取余以及求模的方式获取 / 采用将数字转换成字符串，然后将字符串转换成字符串数组
     */
    private class func fetchBaseNumber(_ num : Int, _ digit : Int)->Int{
        if digit > 0 && digit<=SortSummary.numberLength(num) {
            var numArr : Array<Int> = []
            for char in "\(num)" {
                numArr.append(Int("\(char)")!)
            }
            return numArr[numArr.count-digit]
        }
        return 0
    }
    //5、排序
    class func radixSort(_ list : inout Array<Int>){
        var bucket = SortSummary.createBucket(list.count)
        var maxNum = SortSummary.listMaxItem(list)
        let maxLength = SortSummary.numberLength(maxNum)
        
        for digit in 1...maxLength {
            //入桶
            for item in list {
                let baseNum = SortSummary.fetchBaseNumber(item, digit)
                //根据基数进入相应的桶中
                bucket[baseNum].append(item)
            }
            //出桶
            var index = 0
            for i in 0..<bucket.count{
                while !bucket[i].isEmpty {
                    list[index] = bucket[i].remove(at: 0)
                    index += 1
                }
            }
        }
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
    //会议开始时间
    public var start : Int
    //会议结束时间
    public var end : Int
    
    //初始化
    public init(_ start : Int, _ end : Int){
        self.start = start
        self.end = end
    }
}



//MARK:---------排序方法总结调用
//排序
func sortTest(){
    
    //冒泡
    print("冒泡")
    let array = [1,3,6,9,0,5,2,4,8,7]
    SortSummary.bubbleSort(array)
    SortSummary.bubbleSort1(array)
    SortSummary.bubbleSort2(array)
    print("\n")
    
    //选择
    print("选择")
    let array2 = [8, 5, 2, 6, 9, 3, 1, 4, 0, 7]
    SortSummary.chooseSort(array2)
    print("\n")
    
    //插入
    print("插入")
    let array3 = [8, 3, 5, 4, 6]
    SortSummary.insertSort(array3)
    SortSummary.insertSort1(array3)
    SortSummary.insertSort2(array3)
    SortSummary.insertSort3(array3, <)
    //insertSort3(array3){$0<$1}等同于insertSort3(array3, <)
    SortSummary.insertSort3(array3){$0<$1}
    SortSummary.insertSort3(array3, >)
    print("\n")
    
    //堆
    print("堆")
    var array4 = [62, 88, 58, 47, 62, 35, 73, 51, 99, 37, 93]
    SortSummary.heapSort(&array4)
    print(array4,"\n")
    
    //归并
    print("归并")
    var array5 = [2, 1, 5, 4, 9]
    //        array5 = SortSummary.mergeSort(array5)
    array5 = SortSummary.mergeSort1(array5)
    print(array5)
    array5 = SortSummary.mergeSortBottomUp(array5, <)
    print(array5,"\n")
    
    //快速
    print("快速")
    var array6 = [5, 7, 1, 8, 4]
    SortSummary.quickSort(&array6, 0, array6.count-1)
    print(array6,"\n")
    
    //希尔
    print("希尔")
    var array7 = [49, 38, 65, 97, 26, 13, 27, 49, 55, 4]
    SortSummary.shellSort(&array7)
    print(array7,"\n")
    
    //桶
    print("桶")
    var array8 = [1,34,66,90,99,34,56,2,3,47,66,99]
    array8 = SortSummary.bucketSort(array8, 100)
    print(array8,"\n")
    
    //基排
    print("基排")
    var array9 = [62, 88, 58, 47, 62, 35, 73, 51, 99, 37, 93]
    SortSummary.radixSort(&array9)
    print(array9,"\n")
    
    //实例
    print("实例")
    var array10 = [MeetingTime.init(1, 3), MeetingTime.init(5, 6), MeetingTime.init(4, 7), MeetingTime.init(2, 3)]
    array10 = SortSummary.meetingTimeMerge(array10)
    for i in array10 {
        print(i.start,i.end,"\n")
    }
    
}

//MARK:---------排序类调用
func sortClassTest(){
    commonSort(BubbleSort())
    commonSort(ChooseSort())
    commonSort(InsertSort())
    commonSort(HeapSort())
    commonSort(MergeSort())
    commonSort(QuickSort())
    commonSort(ShellSort())
    commonSort(BucketSort())
    commonSort(RadixSort())
}
private func commonSort(_ sortObject : SortType){
    let list : Array<Int> = [62, 88, 58, 47, 62, 35, 73, 51, 99, 37, 93]
    let sortList = sortObject.sort(list)
    print(sortList)
    print("\n")
}
