//
//  ZhiChuDetailsTableViewController.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/4.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit
import EventKit
class ZhiChuDetailsTableViewController: UITableViewController {

    @IBOutlet weak var ZhiChuDetailMoney: UITextField!
    @IBOutlet weak var ZhiChuDetailKind: UILabel!
    @IBOutlet weak var ZhiChuDetailMessage: UITextField!
    @IBOutlet weak var ZhiChuDetailTime: UITextField!
    
    var ZhiChuitemString:String?
    var ZhiChuitemString2:String?
    var ZhiChuitemString3:String?
    var ZhiChuitemString4:String?
    var ZhiChuhangshu:Int?
    var ZhiChueventStore: EKEventStore!
    var ZhiChudatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
 view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shouhui)))
        ZhiChuDetailMoney?.text=ZhiChuitemString
        ZhiChuDetailKind?.text=ZhiChuitemString2
        ZhiChuDetailMessage?.text=ZhiChuitemString3
        ZhiChuDetailTime?.text=ZhiChuitemString4
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.ZhiChueventStore = EKEventStore()
        //设置提醒时间文本框使用的日期选择器
        ZhiChudatePicker = UIDatePicker()
        ZhiChudatePicker.addTarget(self, action: #selector(ZhiChuDetailsTableViewController.ZhiChuaddDate),
                             for: .valueChanged)
        ZhiChudatePicker.datePickerMode = UIDatePickerMode.dateAndTime
        ZhiChudatePicker.locale = Locale(identifier: "zh_CN")
        ZhiChuDetailTime.inputView = ZhiChudatePicker

        
    }
    
    //日期选择器响应方法
    func ZhiChuaddDate(){
        //日期样式
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        //更新提醒时间文本框
        self.ZhiChuDetailTime.text = formatter.string(from: ZhiChudatePicker.date)
    }

    
    required init(coder aDecoder: NSCoder) {
        print("init ZhiChuDetailsTableViewController")
        super.init(coder: aDecoder)!
    }
    
    deinit {
        print("deinit ZhiChuDetailsTableViewController")
    }
    func tableView1(_ ableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        if indexPath.section == 0 {
            ZhiChuDetailMoney.becomeFirstResponder()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func selectedZhichuDetail(segue:UIStoryboardSegue) {
        let ShouRuPickerViewController = segue.source as! ZhiChuDetailKindTableViewController
        ZhiChuDetailKind.text = ShouRuPickerViewController.savekind
        let kind = ZhiChuDetailKind.text
        print(kind)
        dismiss(animated: true, completion: nil)
    }
    
    
    //点击空白处收回键盘
    func shouhui(sender: UITapGestureRecognizer){
        if sender.state == . ended
        {
            ZhiChuDetailMoney.clearButtonMode = .whileEditing
            ZhiChuDetailMoney.resignFirstResponder()
            ZhiChuDetailMessage.clearButtonMode = .whileEditing
            ZhiChuDetailMessage.resignFirstResponder()
        }
        if sender.state == . ended
        {
            ZhiChuDetailMoney.resignFirstResponder()
            ZhiChuDetailMessage.resignFirstResponder()
        }
        sender.cancelsTouchesInView=false
    }
}
