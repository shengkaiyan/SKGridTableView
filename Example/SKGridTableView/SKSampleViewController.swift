//
//  SKSampleViewController.swift
//  SKGridTableView_Example
//
//  Created by sky on 2019/1/7.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SKGridTableView

class Stock: NSObject {
    @objc var name: String!
    @objc var A1: String!
    @objc var A2: String!
    @objc var A3: String!
    @objc var B1: String!
    @objc var B2: String!
    @objc var B3: String!
    @objc var C1: String!
    @objc var C2: String!
    @objc var C3: String!
    @objc var D1: String!
    @objc var D2: String!
    @objc var D3: String!
    
    public override init() {
        super.init()
    }
    
    public init(name:String, a1:String, a2:String, a3:String, b1:String, b2:String, b3:String, c1:String, c2:String, c3:String, d1:String, d2:String, d3:String) {
        self.name = name
        A1 = a1
        A2 = a2
        A3 = a3
        B1 = b1
        B2 = b2
        B3 = b3
        C1 = c1
        C2 = c2
        C3 = c3
        D1 = d1
        D2 = d2
        D3 = d3
    }
}

class SKSampleViewController: SKGridViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let stocks = [Stock]()
 
        girdDataSource = stocks as [AnyObject]
        let stock = Stock.init(name: "600600", a1: "100", a2: "200", a3: "300", b1: "b100", b2: "b200", b3: "b300", c1: "c100", c2: "c200", c3: "c300", d1: "d100", d2: "d200", d3: "d300")
        print("stock \(stock.value(forKey: "A1"))")
        girdDataSource.append(stock as AnyObject)
        
        gridModel = SKGridModel()
        gridModel.cellItems.append(SKGridItemModel(sectionTitle: "名称", variableName: "name", width: 100))
        gridModel.cellItems.append(SKGridItemModel(sectionTitle: "价格", variableName: "A1", width: 70))
        gridModel.cellItems.append(SKGridItemModel(sectionTitle: "5日", variableName: "B1", width: 200))
        gridModel.cellItems.append(SKGridItemModel(sectionTitle: "10日", variableName: "C1", width: 100))
        gridModel.cellItems.append(SKGridItemModel(sectionTitle: "15日", variableName: "D1", width: 100))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
