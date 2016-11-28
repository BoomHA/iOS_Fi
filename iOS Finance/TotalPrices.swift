//
//  TotalPrices.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/15.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit

class TotalPrices: UITableViewController {

    @IBOutlet weak var TotalShouRu: UILabel!
    @IBOutlet weak var TotalZhiChu: UILabel!
    let zhichuModel = ZhiChuDataModel()
    let shouruModel = ShouRuDataModel()
    override func viewDidLoad() {
        mdzz()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mdzz()
    }
    
    func mdzz() {
        zhichuModel.loadData()
        shouruModel.loadData()
        var money: Int = 0
        for c in zhichuModel.ZhiChuList {
            money += Int(c.money)!
        }
        TotalShouRu.text = String(money)
        money = 0
        for c in shouruModel.ShouruList {
            money += Int(c.money)!
        }
        TotalZhiChu.text = String(money)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}
