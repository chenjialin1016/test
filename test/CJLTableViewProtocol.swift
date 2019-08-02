//
//  CJLTableViewProtocol.swift
//  test
//
//  Created by Jialin Chen on 2019/7/29.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

typealias TableViewCellConfigureBlock = (_ cell : AnyObject, _ items : AnyObject, _ indexPath : IndexPath)->Void

class CJLTableViewProtocol: NSObject ,UITableViewDataSource{
    
    
     var items : NSArray!
     var cellIdentifier : String!
    private var configureCellBlock : TableViewCellConfigureBlock!
    
    init(_ anitems : NSArray, _ aCellIdentifier : String, configureCellBlock: @escaping TableViewCellConfigureBlock){
        self.items = anitems
        self.cellIdentifier = aCellIdentifier
        self.configureCellBlock = configureCellBlock
    }
    
    func itemAtIndexPath(_ indexpath : IndexPath)->AnyObject{
        if self.isDoubleDimensionalArray(){
            let sectionArr : NSArray = self.items![indexpath.section] as! NSArray
            return sectionArr.count > indexpath.row ? sectionArr[indexpath.row] as AnyObject : 0 as AnyObject
        }else{
            return self.items.count > indexpath.section ? self.items![indexpath.section] as AnyObject : 0 as AnyObject
        }
    }
    
    private func isDoubleDimensionalArray()->Bool{
        if self.items.count == 0 {
            return false
        }
        if self.items.isKind(of: NSArray.classForCoder()) {
            return true
        }else{
            return false
        }
    }
    
    
    //MARK:-----------UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count > 0 ? self.items.count : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isDoubleDimensionalArray() {
            let sectionArr : NSArray = self.items![section] as! NSArray
            return sectionArr.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        let item = self.itemAtIndexPath(indexPath)
        self.configureCellBlock(cell, item, indexPath)
        return cell
    }
    
    
    //MARK:-----------UICollectionViewDataSource
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
}
