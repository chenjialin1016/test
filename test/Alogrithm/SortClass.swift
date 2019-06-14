//
//  SortClass.swift
//  test
//
//  Created by  on 2019/5/30.
//  Copyright © 2019年 . All rights reserved.
//

import Foundation

//自定义排序协议
protocol SortType {
    func sort(_ items : Array<Int>)->Array<Int>
}

//为了方便调用，排序统一遵守自定义的排序协议，并实现协议方法


//排序类
//冒泡排序
class BubbleSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("冒泡排序")
        var list = items
        if list.count > 0 {
            list = SortSummary.bubbleSort(list)
            //list = SortSummary.bubbleSort1(list)
            //list = SortSummary.bubbleSort2(list)
        }
        return list
    }
}

//插入排序
class InsertSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("插入排序")
        var list = items
        if list.count > 0 {
            list = SortSummary.insertSort(list)
            //list = SortSummary.insertSort1(list)
            //list = SortSummary.insertSort1(list)
            //list = SortSummary.insertSort3(list, <)
        }
        return list
    }
}

//选择排序
//插入排序
class ChooseSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("选择排序")
        var list = items
        if list.count > 0 {
            list = SortSummary.chooseSort(list)
        }
        return list
    }
}

//堆排序
class HeapSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("堆排序")
        var list = items
        if list.count > 0 {
            SortSummary.heapSort(&list)
        }
        return list
    }
}

//归并排序
class MergeSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("归并排序")
        var list = items
        if list.count > 0 {
            list = SortSummary.mergeSort(list)
            //list = SortSummary.mergeSortBottomUp(list, <)
        }
        return list
    }
}

//快速排序
class QuickSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("快速排序")
        var list = items
        if list.count > 0 {
            SortSummary.quickSort(&list, 0, items.count-1)
        }
        return list
    }
}

//希尔排序
class ShellSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("希尔排序")
        var list = items
        if list.count > 0 {
            SortSummary.shellSort(&list)
        }
        return list
    }
}

//桶排序
class BucketSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("桶排序")
        var list = items
        let max = maxNum(list)
        if list.count > 0 {
            list = SortSummary.bucketSort(list, max)
        }
        return list
    }
    
    private func maxNum(_ list : Array<Int>)->Int{
        var max = list[0]
        for i in list {
            if i > max {
                max = i
            }
        }
        return max+1
    }
}


//基数排序
class RadixSort:SortType{
    func sort(_ items: Array<Int>) -> Array<Int> {
        print("基数排序")
        var list = items
        if list.count > 0 {
            SortSummary.radixSort(&list)
        }
        return list
    }
    
}
