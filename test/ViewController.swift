//
//  ViewController.swift
//  test
//
//  Created by Jialin Chen on 2019/5/9.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
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
    }
    
    func algorithmTest(){
        let nums = [-1, 2, 1, -4]
        let result = Algorithm.threeSumClosest(nums, 1)
        print("result \(result)")
        
        //有效括号
        print("result \(Algorithm.isValid("()"))")
        print("result \(Algorithm.isValid("()[]{}"))")
        print("result \(Algorithm.isValid("(]"))")
        print("result \(Algorithm.isValid("([)]"))")
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
