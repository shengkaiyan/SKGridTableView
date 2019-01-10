//
//  SKGridCell.swift
//  SKGridTableView
//
//  Created by sky on 2019/1/6.
//

import Foundation
import UIKit
import SnapKit

class SKGridCell: UITableViewCell {
    var gridModel: SKGridModel!
    var labels = [UILabel]()

    init(style: UITableViewCellStyle, reuseIdentifier: String?, gridModel: SKGridModel) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.gridModel = gridModel
        self.selectionStyle = UITableViewCellSelectionStyle.none
       
        self.createCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCellUI() {
        var xPosition: CGFloat = 0
        
        for (index, gridItem) in gridModel.cellItems.enumerated() {
            let label = UILabel()
            label.tag = index
            self.contentView.addSubview(label)
            
            label.snp.makeConstraints { (maker) in
                maker.left.equalTo(xPosition)
                maker.top.bottom.equalTo(0)
                maker.width.equalTo(gridItem.width)
            }
            
            xPosition += gridItem.width
            
            self.labels.append(label)
        }
    }
    
    func updateUI(item: AnyObject) {
        for (index,label) in self.labels.enumerated() {
            let gridItem = gridModel.cellItems[index]
            
            label.text = (item.value(forKey: gridItem.variableName) as! String)  
        }
    }
}
