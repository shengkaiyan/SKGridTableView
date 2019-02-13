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
    
    let leftTableView = { () -> UITableView in
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        return tableView
    }()
    
    let rightTableView = { () -> UITableView in
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        return tableView
    }()
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return girdDataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SKGridCell? = nil
        
        if tableView == leftTableView {
            cell = (tableView.dequeueReusableCell(withIdentifier: "leftTableView") as? SKGridCell)
            
            if cell == nil{
                cell = SKGridCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "leftTableView", gridModel: gridModel, alignment: .left)
            }
        } else {
            cell = (tableView.dequeueReusableCell(withIdentifier: "rightTableView") as? SKGridCell)
            
            if cell == nil{
                cell = SKGridCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "rightTableView", gridModel: gridModel, alignment: .right)
            }
        }
        
        cell?.updateUI(item: girdDataSource[indexPath.row])
        
        return cell!
    }

    let rightTableSuperScrollView = UIScrollView()
    var leftTableViewWidth: CGFloat = 0
    var rightTableViewWidth: CGFloat = 0
    
    var lastPostionX: CGFloat = 0
    var isScrollToRight: Bool = true
    var criticalPoints:[CGFloat] = [0]
    
    @objc func click() {
        
    }
    
    let label = UIButton()
    let contentview = UIView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        leftTableView.rowHeight = 100
        rightTableView.rowHeight = 100
        
        view.addSubview(leftTableView)
        view.addSubview(rightTableSuperScrollView)
        
        rightTableSuperScrollView.delegate = self
    
//        scrollView.backgroundColor = UIColor.blue
        
        rightTableSuperScrollView.addSubview(contentview)
        contentview.addSubview(rightTableView)
//        scrollView.addSubview(leftTableView)
        
        contentview.snp.makeConstraints { (make) in
            make.edges.equalTo(rightTableSuperScrollView)
            make.width.equalTo(rightTableSuperScrollView)
        }
        
        rightTableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(700)
            make.bottom.equalTo(0)
            }

//        leftTableView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 80)
//        leftTableView.backgroundColor = UIColor.red
        
        
//        label.frame = CGRect.init(x: 100, y: 400, width: 100, height: 100)
//        label.backgroundColor = UIColor.yellow
//        label.setTitle("ViceroyTrace.framework/ViceroyTrace (0x12b6ee4d0) and /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/AVConference.framework/AVConference (0x12a81ae38). One of the two will be used. Which one is undefined.)", for: .normal)
//        label.setTitleColor(UIColor.black, for: .normal)
//        label.addTarget(self, action: #selector(click), for: .touchUpInside)
//        scrollView.addSubview(label)
//        label.snp.makeConstraints { (maker) in
//                        maker.edges.equalTo(self.view)
////            maker.left.top.right.bottom.equalTo(0)
//        }

                
        leftTableView.dataSource = self
        leftTableView.delegate = self

        rightTableView.dataSource = self
        rightTableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    open func reloadData() {
        var cellItems = gridModel.cellItems[0..<gridModel.fixedColumn]
        for modelItem in  cellItems {
            leftTableViewWidth = leftTableViewWidth + modelItem.width
        }
        
        cellItems = gridModel.cellItems[gridModel.fixedColumn..<gridModel.cellItems.count]
        for modelItem in  cellItems {
            rightTableViewWidth = rightTableViewWidth + modelItem.width
            criticalPoints.append(rightTableViewWidth)
        }
        
        leftTableView.snp.remakeConstraints { (maker) in
            maker.left.top.bottom.equalTo(0)
            maker.width.equalTo(leftTableViewWidth)
        }
        
//        rightTableView.snp.remakeConstraints { (make) in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(leftTableView.frame.size.height)
//            make.bottom.equalTo(0)
//        }
        
        rightTableSuperScrollView.contentSize = CGSize.init(width: rightTableViewWidth, height: view.frame.size.height)
        
        rightTableSuperScrollView.snp.remakeConstraints { (maker) in
            maker.left.equalTo(leftTableViewWidth)
            maker.top.right.bottom.equalTo(0)
        }
        
        contentview.snp.remakeConstraints { (make) in
            make.edges.equalTo(rightTableSuperScrollView)
            make.width.equalTo(rightTableViewWidth)
        }

        
//        scrollView.snp.remakeConstraints { (maker) in
//            //            maker.edges.equalTo(20)
//            maker.left.top.right.bottom.equalTo(0)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.leftTableView.snp.remakeConstraints { (maker) in
//                maker.top.bottom.left.equalTo(0)
//                maker.width.equalTo(self.rightTableViewWidth)
//            }
//
//            self.scrollView.contentSize = CGSize.init(width: self.rightTableViewWidth, height: self.view.frame.size.height)
//
////            self.leftTableView.reloadData()
//        }
        
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if offset.x == 0, scrollView.isKind(of: UITableView.self) {
            let otherTableView = scrollView == leftTableView ? rightTableView : leftTableView
            otherTableView.contentOffset = offset
        }
        
//        print("scrollViewDidScroll \(scrollView)")
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == rightTableSuperScrollView {
            let scrollToScrollStop = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
            if scrollToScrollStop {
                scrollViewDidEndScroll(offset: scrollView.contentOffset)
            }
            
            print("scrollViewDidEndDecelerating")
//            print("scrollViewDidEndDecelerating \(scrollView)")
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate && scrollView == rightTableSuperScrollView {
            let dragToDragStop = scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
            if dragToDragStop {
                scrollViewDidEndScroll(offset: scrollView.contentOffset)
            }
            
            print("scrollViewDidEndDragging")
//            print("scrollViewDidEndDragging \(scrollView) \(decelerate)")
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        print("scrollViewDidEndScrollingAnimation \(scrollView)")
    }
    
    func scrollViewDidEndScroll(offset: CGPoint) {
        if offset.x > lastPostionX {
            isScrollToRight = true  // 向右滑动
        } else {
            isScrollToRight = false  // 向左滑动
        }
        
        lastPostionX = offset.x
        
        for index in 0 ..< criticalPoints.count-1 {
            let min = criticalPoints[index]
            let max = criticalPoints[index+1]
            
            if offset.x >= min && offset.x <= max {
                var point = offset
                if isScrollToRight {
                    point.x = max
                } else {
                    point.x = min
                }
                
                if point.x + rightTableSuperScrollView.frame.size.width <= rightTableViewWidth {
                    print("EndScroll \(index)")
                    UIView.animate(withDuration: 0.4) {
                        self.rightTableSuperScrollView.contentOffset = point
                    }
                }
                
                return
            }
        }
//        var lastPostionX: CGFloat = 0
//        var isScrollToRight: Bool = true
//        var criticalPoints:[CGFloat] = [0]
    }
    
    override open func viewDidLayoutSubviews() {
//        leftTableView.snp.remakeConstraints { (maker) in
//            //            maker.edges.equalTo(0)
//            maker.left.top.right.bottom.equalTo(0)
//        }
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

