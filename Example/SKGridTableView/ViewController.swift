//
//  ViewController.swift
//  SKGridTableView
//
//  Created by shengkaiyan on 01/04/2019.
//  Copyright (c) 2019 shengkaiyan. All rights reserved.
//

import UIKit
import SKGridTableView

class ViewController: UIViewController {

    @IBAction func showGridView(_ sender: Any) {
        let gridTableView = SKSampleViewController()
        self.navigationController?.pushViewController(gridTableView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

