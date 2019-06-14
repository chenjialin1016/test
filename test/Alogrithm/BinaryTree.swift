//
//  BinaryTree.swift
//  test
//
//  Created by  on 2019/5/24.
//  Copyright © 2019年 . All rights reserved.
//

import Foundation

//二叉树线索化
public class BinaryTreeNode{
    public var val : String
    public var left : BinaryTreeNode?
    public var right : BinaryTreeNode?
    
    //true 指向左子树，false 指向前驱
    public var leftTag : Bool = true
    //true 指向右子树，false 指向后继
    public var rightTag : Bool = true
    
    public init(_ val : String){
        self.val = val
    }
}

class BinaryTree{
    private var root : BinaryTreeNode?
    
    fileprivate var items : Array<String>
    fileprivate var index = -1
    
    fileprivate var preNode : BinaryTreeNode?
    fileprivate var headNode : BinaryTreeNode?
    
    init(_ items : Array<String>) {
        self.items = items
        self.root = self.createTree()
        
        self.headNode = BinaryTreeNode("")
        self.headNode?.left = self.root
        self.headNode?.leftTag = true
        
        self.preNode = headNode
    }
    //以先序二叉树创建二叉树
    fileprivate func createTree()->BinaryTreeNode?{
        self.index = self.index+1
        if index < self.items.count && index >= 0{
            let item = self.items[index]
            if item == ""{
                return nil
            }else{
                let root = BinaryTreeNode(item)
                root.left = createTree()
                root.right = createTree()
                return root
            }
        }
        return nil
    }
    
    //前序遍历
    fileprivate func preorderTraversal(_ root : BinaryTreeNode?){
        //遍历跟节点
        guard let root = root else {
            return
        }
        print(root.val, separator: "", terminator: " ")
        if root.leftTag {
            preorderTraversal(root.left)
        }
        if root.rightTag {
            preorderTraversal(root.right)
        }
    }
    func preOrder(){
        print("先序遍历")
        preorderTraversal(root)
        print("\n")
    }
    
    //中序遍历,该线索化，是将结果生成一个链表
    private func inorderTraversal(_ root : BinaryTreeNode?){
        
        if root != nil{
            inorderTraversal(root?.left)
            
            //如果节点的左节点为nil，那么将该节点指向中序遍历的前驱
            if root?.left == nil {
                root?.leftTag = false
                root?.left = preNode
            }
            
            //如果该节点的中序遍历的前驱的右节点为nil，那么将该前驱节点的右节点指向该点进行关联
            if preNode?.right == nil{
                preNode?.rightTag = false
                preNode?.right = root
            }
            preNode = root
            inorderTraversal(root?.right)
        }
        
    }
    func inOrder(){
        inorderTraversal(root)
    }
    
    func displayBinaryTree(){
        print("遍历线索化二叉树\n")
        var cursor = self.headNode?.right
        while cursor != nil {
            print((cursor?.val)!, separator:  "", terminator: " -> ")
            cursor = cursor?.right
        }
        print("end\n")
    }
    
}
