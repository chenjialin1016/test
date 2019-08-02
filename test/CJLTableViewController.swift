//
//  CJLTableViewController.swift
//  test
//
//  Created by Jialin Chen on 2019/7/29.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

class CJLTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let configureBlock : TableViewCellConfigureBlock = {cell,items,indexPath in
        }
        
        self.tableView.dataSource = CJLTableViewProtocol.init(["luckdraw", "popuparize"], "cell", configureCellBlock: configureBlock)
        
        let didSelectBlock : TableViewDidSelectBlock = {tableView,indexPath in
        }
        self.tableView.delegate = CJLTableViewDelegate.init(nil, nil, 30, 0, 0, didSelectBlock)
        
        
    }

    
}
