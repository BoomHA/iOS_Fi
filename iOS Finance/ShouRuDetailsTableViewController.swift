//
//  ShouRuDetailsTableViewController.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/1.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit
import EventKit
class ShouRuDetailsTableViewController: UITableViewController {
    @IBOutlet weak var ShouRuDetailMoney: UITextField!
    
    @IBOutlet weak var ShouRuDetailKind: UILabel!
    @IBOutlet weak var ShouRuDetailMessage: UITextField!
    @IBOutlet weak var ShouRuDetailTime: UITextField!
    
    var itemString:String?
    var itemString2:String?
    var itemString3:String?
    var itemString4:String?
    var hangshu:Int?
    var eventStore: EKEventStore!
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shouhui)))
       ShouRuDetailMoney?.text = itemString
        ShouRuDetailKind?.text=itemString2
        ShouRuDetailMessage?.text=itemString3
        ShouRuDetailTime?.text=itemString4
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
        ShouRuDetailTime.inputView = datePicker

    }
    
    //日期选择器响应方法
    func addDate(){
        //日期样式
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        //更新提醒时间文本框
        self.ShouRuDetailTime.text = formatter.string(from: datePicker.date)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    required init(coder aDecoder: NSCoder) {
        print("init ShouRuDetailsTableViewController")
        super.init(coder: aDecoder)!
    }
    
    deinit {
        print("deinit ShouRuDetailsTableViewController")
    }
    func tableView1(_ ableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        if indexPath.section == 0 {
            ShouRuDetailMoney.becomeFirstResponder()
        }
    }

    
    @IBAction func selectedShouruDetail(segue:UIStoryboardSegue) {
        let ShouRuPickerViewController = segue.source as! ShouruDetailLindTableViewController
        ShouRuDetailKind.text = ShouRuPickerViewController.savekind
        let kind = ShouRuDetailKind.text
        print(kind)
        dismiss(animated: true, completion: nil)
    }
    
    
    //点击空白处收回键盘
    func shouhui(sender: UITapGestureRecognizer){
        if sender.state == . ended
        {
            ShouRuDetailMessage.clearButtonMode = .whileEditing
            ShouRuDetailMessage.resignFirstResponder()
            ShouRuDetailMoney.clearButtonMode = .whileEditing
            ShouRuDetailMoney.resignFirstResponder()
        }
        if sender.state == . ended
        {
            ShouRuDetailMessage.resignFirstResponder()
            ShouRuDetailMoney.resignFirstResponder()
        }
        sender.cancelsTouchesInView=false
    }
    


   
}
