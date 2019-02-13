//
//  SKGridModel.swift
//  SKGridTableView
//
//  Created by sky on 2019/1/5.
//

import Foundation

open class SKGridItemModel: NSObject {
    var title: String!
    var variableName: String!
    var width: CGFloat!
    
    public override init() {
        super.init()
    }
    
    public init(sectionTitle: String, variableName: String, width: CGFloat) {
        self.title = sectionTitle
        self.variableName = variableName
        self.width = width
    }
}

open class SKGridModel: NSObject {
    open var fixedColumn: Int = 0
    open var cellItems = [SKGridItemModel]()
    
    public override init() {
        super.init()
    }
}
