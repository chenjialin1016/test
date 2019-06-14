//
//  ViewController.swift
//  test
//
//  Created by  on 2019/5/9.
//  Copyright © 2019年 . All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let items: Array<String> = ["A", "B", "D", "", "", "E", "", "", "C", "","F", "", ""]
        let generalBinaryTree: GeneralTree = GeneralTree(items)
        
        //二叉树的遍历
        generalBinaryTree.preOrder()
        generalBinaryTree.inOrder()
        generalBinaryTree.postOrder()        
        generalBinaryTree.levelOrder()
       
        
        //二叉树线索化
        let binaryTree : BinaryTree = BinaryTree(items)
        binaryTree.inOrder()
        binaryTree.displayBinaryTree()
        binaryTree.preOrder()
        
        //算法调用
        self.algorithmTest()
        
        //排序
        self.sortTest()
        
        //算法排序类调用
//        self.sortClassTest()
        
        //重构规则
        self.codeReviewTest()
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
//        print("全排列")
//        print(Algorithm.permute([1, 2, 3]))
//        print("\n")
        
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
    
    //MARK:---------重构规则
    func codeReviewTest(){
        
        //函数重构
        methodReviewTest()
        
        //类重构
        classReviewTest()
        
        //数据重构
        dataReviewTest()
        
        //条件表达式重构
        conditionalExpressionReviewTest()
        
        //继承关系重构
        extendsReviewTest()
        
        //规则完成案例
        
    }
    
    /*===========================================================================================*/
    //5、寻找字符串数组中最长公共前缀 --找到所有字符串中的公共前缀的最大长度--O(S⋅log(n)) n为所有字符串中字符数量的总和（字典树查找法）
    //给定一些键值字符串 S =[S1, S2, ...Sn]，我们要找到字符串 q 与 S 的最长公共前缀。
//    func longestCommonPrefix(_ strs: [String]) -> String {
//
//        if strs.count == 0 {
//            return ""
//        }
//
//
//
//    }
    
}

////用结构体定义一个字典树的数据结构
//struct Trie<Element : Hashable> {
//    //children是一个字典，值是一个子字典树，键是子shu的前缀
//    var children : [Element:Trie]!
//    //定义了当前节点为止的组合是否是一个元素
//    var isElement : Bool!
//
//    //打印出字典树中包含的所有关联元素
//    /*
//     [] + [["r"]] = [["r"]]-->对于一个嵌套的二维数组，直接加一个空的一维数组，这个空的一维数组就被加入为二维数组的一个元素
//     [[]] + [["r"]] = [[], ["r"]]-->两个嵌套的二维数组相加，则会合并为一个二维数组
//     */
//    var elements : [[Element]]{
//        var result :[[Element]] = isElement ? [[]] : []
//        for (key, value) in children {
//            result += value.elements.map{ [key] + $0 }
//        }
//        return result
//    }
//
//    init() {
//        isElement = false
//        children = [:]
//    }
//
//    init(_ isElement : Bool, _ children : [Element : Trie]) {
//        self.isElement = isElement
//        self.children = children
//    }
//
//    //接收数组参数的初始化方法
//    init(_ key:[Element]) {
//        if let (head, tail) = key.decompose {
//            let children = [head : Trie.init(tail)]
//            self = Trie(false, children)
//        }else{
//            self = Trie(true, [:])
//        }
//    }
//
//    //遍历传入的数组，并检查每一个节点的children键组
//    /*
//     1、如果键组为空，我们将isElement设置为true，t然后不再修改剩余的字典树，表明已经插入完毕
//     2、如果键组不为空，且键组的head已经存在于当前节点children字典中，我们只需要递归的调用该函数，将键组的tail插入到对应的子字典树中
//     3、如果键组不为空，且第一个键head并不是该字典树中children字典的某条记录，就创建一颗新的字典树来存储键组中剩下的键，然后，以head和tail数组生成对应新的字典树，储存在当前节点中，完成插入操作
//     */
//    func insert(_ key : [Element])->Trie<Element>{
//        guard let (head, tail) = key.decompose else {
//            return Trie.init(true, self.children)
//        }
//
//        var newChildren = self.children
//        if let nextTrie : Trie = self.children[head] {
//            newChildren![head] = nextTrie.insert(tail)
//        }else{
//            newChildren![head] = Trie.init(tail)
//        }
//
//        return Trie.init(isElement, newChildren!)
//    }
//
//    //将一个关联数组组合成字典树
//    func buildStringTrie(_ words : [String])->Trie<Character>{
//        let emptyTrie = Trie<Character>.init()
//        return words.reduce(emptyTrie, { (result, word) -> Trie<Character> in
//            result.insert(Array.init(word))
//        })
//    }
//
//    //检索某个字符串是否在字典树的方法
//    func lookup(_ key : [Element])->Bool{
//        guard let (head, tail) = key.decompose else {
//            return isElement
//        }
//        guard let subtrie = children[head] else {
//            return false
//        }
//        return subtrie.lookup(tail)
//    }
//
//    //检索某个前缀对应的字典树的方法
//    func withPrefix(_ prefix : [Element])->Trie<Element>?{
//        guard let (head, tail) = prefix.decompose else {
//            return self
//        }
//        guard let remainder = children[head] else {
//            return nil
//        }
//        return remainder.withPrefix(tail)
//    }
//}
//
////扩展数组的递归方式--即从最原始的数组j逐渐去除一定数量元素形成子数组
//extension Array{
//    var decompose : (Element, [Element])?{
//        //如果数组为空则返回 nil，否则返回一个元组，元组第一个元素是当前数组的头元素，第二个元素是去掉第一个元素之后由该数组其余元素组成的新数组
//        return isEmpty ? nil : (self[startIndex],Array(self.dropFirst()))
//    }
//}


/*==========================================================================================*/
//1、字典树节点定义
//class TrieNode{
//
//    //记录该字符出现次数
//    var nCount : Int!
//    //记录该字符
//    var ch : Character!
//    //记录子节点
//    var child : [TrieNode?]!
//
//
//
//    init() {
//        nCount = 1
//        child = [TrieNode?]()
//    }
//}
//
//class Trie{
//
//    //建立字典树
//    //在字典树中插入一个单词
//    public func createTrie(_ node : TrieNode?,_ str : String){
//        if str.count == 0 {
//            return
//        }
//
//       var node = node
//
//        //将目标单词转换为数组
//        var letters : [Character] = [Character]()
//        for i in str {
//            letters.append(i)
//        }
//
//        for i in 0..<str.count {
//            //用相对于a字母的值作为下标索引，也隐式的记录了该字母的值
//            let pos = self.characterToInt(letters[i])-characterToInt("a")
//            if node!.child![pos] == nil {
//                node!.child![pos] = TrieNode.init()
//            }else{
//                node!.child![pos]!.nCount += 1
//            }
//            node!.ch = letters[i]
//            node = node!.child![pos]
//        }
//    }
//
//    //将字符转为整数
//    private func characterToInt(_ ch : Character)->Int{
//        var code1  = 0
//        for code in String(ch).unicodeScalars {
//            code1 = Int(code.value)
//        }
//        return code1
//    }
//
//    //字典树的查找
//    public func findCount(_ node : TrieNode?, _ str : String) -> Int{
//        if str.count == 0 {
//            return -1
//        }
//
//        var node = node
//        //将目标单词转换为数组
//        var letters : [Character] = [Character]()
//        for i in str {
//            letters.append(i)
//        }
//
//        for i in 0..<str.count {
//            //用相对于a字母的值作为下标索引，也隐式的记录了该字母的值
//            let pos = self.characterToInt(letters[i])-characterToInt("a")
//            if node!.child![pos] == nil {
//                return 0
//            }else{
//                node = node?.child[pos]
//            }
//        }
//        return (node?.nCount)!
//    }
//}
