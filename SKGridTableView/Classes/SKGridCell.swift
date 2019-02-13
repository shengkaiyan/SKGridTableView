//
//  SKGridCell.swift
//  SKGridTableView
//
//  Created by sky on 2019/1/6.
//

import Foundation
import UIKit
import SnapKit

enum CellAlignment : Int {
    case left // left tableview cell
    case right // right tableview cell
}

class SKGridCell: UITableViewCell {
    var gridModel: SKGridModel!
    var labels = [UILabel]()
    var alignment = CellAlignment.left

    init(style: UITableViewCellStyle, reuseIdentifier: String?, gridModel: SKGridModel, alignment: CellAlignment) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.gridModel = gridModel
        self.alignment = alignment
        self.selectionStyle = UITableViewCellSelectionStyle.none
       
        self.createCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCellUI() {
        var xPosition: CGFloat = 0
        
        var cellItems: ArraySlice<SKGridItemModel>
        if alignment == .left {
            cellItems = gridModel.cellItems[0..<gridModel.fixedColumn]
        } else {
            cellItems = gridModel.cellItems[gridModel.fixedColumn..<gridModel.cellItems.count]
        }
        
        for (index, gridItem) in cellItems.enumerated() {
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
        var cellItems: ArraySlice<SKGridItemModel>
        if alignment == .left {
            cellItems = gridModel.cellItems[0..<gridModel.fixedColumn]
        } else {
            cellItems = gridModel.cellItems[gridModel.fixedColumn..<gridModel.cellItems.count]
        }
        
        for (index, gridItem) in cellItems.enumerated() {
            let label = self.labels[index]
            
            label.text = (item.value(forKey: gridItem.variableName) as! String)

            
//            var value = item.value(forKey: gridItem.variableName)
//            switch item {
//            case is Int:
//                value = String(value as! Int)
//            case _ = value as! String: break
//
//            default:
//                value = ""
//                break
//            }
//
//            label.text = value as? String
        }
    }
}
