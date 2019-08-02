//
//  CJLTableViewDelegate.swift
//  test
//
//  Created by Jialin Chen on 2019/7/29.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

typealias TableViewDidSelectBlock = (_ tableView : UITableView, _ indexPath : IndexPath)->Void

class CJLTableViewDelegate: NSObject, UITableViewDelegate{
    
    private var headerV : UIView!
    private var footerV : UIView!
    private var rowHeight : CGFloat!
    private var headerH : CGFloat!
    private var footerH : CGFloat!
    private var didSelectBlock : TableViewDidSelectBlock!

    init(_ headerV : UIView?, _ footerV : UIView?, _ rowHeight : CGFloat, _ headerH : CGFloat, _ footerH : CGFloat, _ didSelectBlock : @escaping TableViewDidSelectBlock) {
        self.headerV = headerV
        self.footerV = footerV
        self.rowHeight = rowHeight
        self.headerH = headerH
        self.footerH = footerH
        self.didSelectBlock = didSelectBlock
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.rowHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerH
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.footerH
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerV = UIView.init()
        if (self.headerV == nil) {
            self.headerV.frame = CGRect.init(x: 0, y: 0, width: self.headerV.frame.size.width, height: self.headerV.frame.size.height)
            headerV.frame.size = CGSize.init(width: self.headerV.frame.size.width, height: self.headerV.frame.size.height)
            headerV.backgroundColor = UIColor.white
            headerV.addSubview(self.headerV)
        }
        return headerV
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footerV = UIView.init()
        if self.footerV == nil {
            footerV = self.XC_copyAView(self.footerV)
        }
        return footerV
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectBlock(tableView, indexPath)
    }
    
    //深复制uiview
    func XC_copyAView(_ view : UIView)->UIView{
        let tempArchive = NSKeyedArchiver.archivedData(withRootObject: view)
        return NSKeyedUnarchiver.unarchiveObject(with: tempArchive) as! UIView
    }
}
