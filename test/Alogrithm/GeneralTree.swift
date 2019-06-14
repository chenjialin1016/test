//
//  Tree.swift
//  test
//
//  Created by  on 2019/5/23.
//  Copyright © 2019年 . All rights reserved.
//

import Foundation

public class GeneralTreeNode{
    public var val : String
    public var left : GeneralTreeNode?
    public var right : GeneralTreeNode?
    public init(_ val : String){
        self.val = val
    }
}

class GeneralTree{
    private var root : GeneralTreeNode?
    
    fileprivate var items : Array<String>
    fileprivate var index = -1
    
    init(_ items : Array<String>) {
        self.items = items
        self.root = self.createTree()
    }
    
    //以先序二叉树创建二叉树
    fileprivate func createTree()->GeneralTreeNode?{
        self.index = self.index+1
        if index < self.items.count && index >= 0{
            let item = self.items[index]
            if item == ""{
                return nil
            }else{
                let root = GeneralTreeNode(item)
                root.left = createTree()
                root.right = createTree()
                return root
            }
        }
        return nil
    }
    
    
    //计算树的最大深度
    private func maxDepth(_ root : GeneralTreeNode?)->Int{
        guard let root = root else{
            return 0
        }
        return max(maxDepth(root.left), maxDepth(root.right))+1
    }
    func maxDepth()->Int{
        return maxDepth(root)
    }
    
    //判断一棵树是否是二叉查找树
    func isValidBST(_ root : GeneralTreeNode?)->Bool{
        return _helper(root, nil, nil)
    }
    private func _helper(_ node : GeneralTreeNode?, _ min : String?, _ max : String?)->Bool{
        guard let node = node else{
            return true
        }
        //所有的右子节点>root
        if let min = min, node.val <= min {
            return false
        }
        //所有的左子节点<root
        if let max = max, node.val >= max {
            return false
        }
        
        return _helper(node.left, min,node.val)&&_helper(node.right, node.val, max)
    }
    
    //前序遍历
    private func preorderTraversal(_ root : GeneralTreeNode?){
       //遍历跟节点
        guard let root = root else {
            print("空", separator: "", terminator: " ")
            return
        }
        print(root.val, separator: "", terminator: " ")
        preorderTraversal(root.left)
        preorderTraversal(root.right)
    }
    func preOrder(){
        print("先序遍历")
        preorderTraversal(root)
        print("\n")
    }
    
    //中序遍历
    private func inorderTraversal(_ root : GeneralTreeNode?){
        guard let root = root else {
            print("空", separator: "", terminator: " ")
            return
        }
        
        inorderTraversal(root.left)
        print(root.val, separator: "", terminator: " ")
        inorderTraversal(root.right)
    }
    func inOrder(){
        print("中序遍历")
        inorderTraversal(root)
        print("\n")
    }
    
    //后序遍历
    private func postOrderTraversal(_ root : GeneralTreeNode?){
        guard let root = root else {
            print("空", separator: "", terminator: " ")
            return
        }
        
        postOrderTraversal(root.left)
        postOrderTraversal(root.right)
        print(root.val, separator: "", terminator: " ")
    }
    func postOrder(){
        print("后序遍历")
        postOrderTraversal(root)
        print("\n")
    }
    
    
    //层级遍历--队列实现
    private func levelOrder(_ root : GeneralTreeNode?){
        var res = [[String]]()
        
        //用数组实现队列
        var queue = [GeneralTreeNode]()
        
        if let root = root {
            queue.append(root)
        }
        
        while queue.count > 0 {
            var size = queue.count
            var level = [String]()
            
            for _ in 0..<size{
                let node = queue.removeFirst()
                
                level.append(node.val)
                
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right{
                    queue.append(right)
                }
            }
            res.append(level)
        }
        print("res \(res)")
    }
    func levelOrder(){
        print("层级遍历")
        levelOrder(root)
        print("\n")
    }
    
    
    
    
}
