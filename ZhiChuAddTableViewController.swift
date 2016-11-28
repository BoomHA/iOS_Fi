//
//  ZhiChuAddTableViewController.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/4.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit
import EventKit
class ZhiChuAddTableViewController: UITableViewController {

    @IBOutlet weak var ZhiChuAddMoney: UITextField!
    @IBOutlet weak var ZhiChuAddMessage: UITextField!
    @IBOutlet weak var ZhiChuAddTime: UITextField!
    
    @IBOutlet weak var ZhiChukind: UILabel!
    
    var ZhiChuplayer:ZhiChuDataModel!
    var selectedKind:String? = nil
    var selectedKindIndex:Int? = nil
    var ZhiChueventStore: EKEventStore!
    var ZhiChudatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shouhui)))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.ZhiChueventStore = EKEventStore()
        //设置提醒时间文本框使用的日期选择器
        ZhiChudatePicker = UIDatePicker()
        ZhiChudatePicker.addTarget(self, action: #selector(ZhiChuAddTableViewController.ZhiChuaddDate),
                             for: .valueChanged)
        ZhiChudatePicker.datePickerMode = UIDatePickerMode.dateAndTime
        ZhiChudatePicker.locale = Locale(identifier: "zh_CN")
        ZhiChuAddTime.inputView = ZhiChudatePicker

    }
    
    //日期选择器响应方法
    func ZhiChuaddDate(){
        //日期样式
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        //更新提醒时间文本框
        self.ZhiChuAddTime.text = formatter.string(from: ZhiChudatePicker.date)
    }

    required init(coder aDecoder: NSCoder) {
        print("init ZhiChuPlayerDetailsViewController")
        super.init(coder: aDecoder)!
    }
    
    deinit {
        print("deinit ZhiChuPlayerDetailsViewController")
    }
    
    @IBAction func selectedZhichuAdd(segue:UIStoryboardSegue) {
        let ShouRuPickerViewController = segue.source as! ZhiChuKindViewTableViewController
        ZhiChukind.text = ShouRuPickerViewController.savekind
        let kind = ZhiChukind.text
        print(kind)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //点击空白处收回键盘
    func shouhui(sender: UITapGestureRecognizer){
        if sender.state == . ended
        {
            ZhiChuAddMoney.clearButtonMode = .whileEditing
            ZhiChuAddMoney.resignFirstResponder()
            ZhiChuAddMessage.clearButtonMode = .whileEditing
            ZhiChuAddMessage.resignFirstResponder()
        }
        if sender.state == . ended
        {
            ZhiChuAddMoney.resignFirstResponder()
            ZhiChuAddMessage.resignFirstResponder()
        }
        sender.cancelsTouchesInView=false
    }



}
