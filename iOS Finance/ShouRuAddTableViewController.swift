//
//  ShouRuAddTableViewController.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/1.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit
import EventKit
class ShouRuAddTableViewController: UITableViewController {
    
    @IBOutlet weak var kinddetail: UILabel!
    @IBOutlet weak var addmoeney: UITextField!
    @IBOutlet weak var addtime: UITextField!
    @IBOutlet weak var addmessage: UITextField!
    var Shouruplayer:ShouRuDataModel!
    var selectedKind:String? = nil
    var selectedKindIndex:Int? = nil
    var eventStore: EKEventStore!
    var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shouhui)))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.eventStore = EKEventStore()
        //设置提醒时间文本框使用的日期选择器
        datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(ShouRuAddTableViewController.addDate),
                             for: .valueChanged)
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.locale = Locale(identifier: "zh_CN")
        addtime.inputView = datePicker
    }
    
    
    /// 日期选择器响应方法
    func addDate(){
        //日期样式
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        //更新提醒时间文本框
        self.addtime.text = formatter.string(from: datePicker.date)
    }
    
    required init(coder aDecoder: NSCoder) {
        print("init PlayerDetailsViewController")
        super.init(coder: aDecoder)!
    }
    
    deinit {
        print("deinit PlayerDetailsViewController")
    }
    
    
    override func tableView(_ ableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        if indexPath.section == 0 {
            addmoeney.becomeFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
//    
//    @IBAction func selectedShouru(segue:UIStoryboardSegue) {
//        let ShouRuPickerViewController = segue.source as! ShouRuKindViewTableViewController
//        kinddetail.text = ShouRuPickerViewController.savekind
//        let kind = kinddetail.text
//        print(kind)
//        dismiss(animated: true, completion: nil)
//    }
//    
    
    @IBAction func selectedShouru(segue:UIStoryboardSegue) {
        let ShouRuPickerViewController = segue.source as! ShouRuKindViewTableViewController
        kinddetail.text = ShouRuPickerViewController.savekind
        let kind = kinddetail.text
        print(kind)
        dismiss(animated: true, completion: nil)
    }
    
    
    //点击空白处收回键盘
    func shouhui(sender: UITapGestureRecognizer){
        if sender.state == . ended
        {
            addmoeney.clearButtonMode = .whileEditing
            addmoeney.resignFirstResponder()
            addmessage.clearButtonMode = .whileEditing
            addmessage.resignFirstResponder()
        }
        if sender.state == . ended
        {
            addmoeney.resignFirstResponder()
            addmessage.resignFirstResponder()
        }
        sender.cancelsTouchesInView=false
    }


}


