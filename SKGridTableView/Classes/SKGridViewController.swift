//
//  SKGridViewController.swift
//  SKGridTableView
//
//  Created by shengkaiyan on 01/04/2019.
//  Copyright (c) 2019 shengkaiyan. All rights reserved.
//

import UIKit

open class SKGridViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    open var girdDataSource: [AnyObject]!
    open var gridModel: SKGridModel!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return girdDataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SKGridCell? = nil
        
        cell = (tableView.dequeueReusableCell(withIdentifier: "cellID") as? SKGridCell)
        
        if cell == nil{
            cell = SKGridCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellID", gridModel: gridModel)
        }
        
        cell?.updateUI(item: girdDataSource[indexPath.row])
        
        return cell!
    }

    let leftTableView = { () -> UITableView in
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        return tableView
    }()
    
    let rightTableView = { () -> UITableView in
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        return tableView
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(leftTableView)
        leftTableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(0)
        }
                
        leftTableView.dataSource = self
        leftTableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

