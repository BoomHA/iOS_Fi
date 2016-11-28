//
//  ZhiChuTableViewController.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/4.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit

class ZhiChuTableViewController: UITableViewController{
    var ZhiChudataModel = ZhiChuDataModel()
    @IBOutlet var mdzz: UISearchBar!
    @IBAction func ZhiChueditBarBtnClick(_ sender: UIBarButtonItem) {
        //在正常状态和编辑状态之间切换
        if(self.tableView!.isEditing == false){
            self.tableView!.setEditing(true, animated:true)
            sender.title = "保存"
        }
        else{
            self.tableView!.setEditing(false, animated:true)
            sender.title = "编辑"
        }
        //重新加载表数据（改变单元格输入框编辑/只读状态）
        self.tableView?.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ZhiChudataModel.loadData()
        tableView.reloadData()
    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //在编辑状态，可以拖动设置cell位置
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //移动cell事件
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath,to toIndexPath: IndexPath) {
        if fromIndexPath != toIndexPath{
            //获取移动行对应的值
            let itemValue:ZhiChuInfo = ZhiChudataModel.ZhiChuList[fromIndexPath.row]
            //删除移动的值
            ZhiChudataModel.ZhiChuList.remove(at: fromIndexPath.row)
            //如果移动区域大于现有行数，直接在最后添加移动的值
            if toIndexPath.row > ZhiChudataModel.ZhiChuList.count{
                ZhiChudataModel.ZhiChuList.append(itemValue)
            }else{
                //没有超过最大行数，则在目标位置添加刚才删除的值
                ZhiChudataModel.ZhiChuList.insert(itemValue, at:toIndexPath.row)
            }
            ZhiChudataModel.saveData()
        }
    }
    
    //删除
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)
        -> UITableViewCellEditingStyle
    {
        if(self.tableView.isEditing == false)
        {
            return UITableViewCellEditingStyle.none
        }
        else
        {
            return UITableViewCellEditingStyle.delete
        }
    }
    
    
    override func tableView(_ tableView: UITableView,
                            titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath)
        -> String? {
            return "确定删除？"
    }
    
    
    //编辑完毕（这里只有删除操作）
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath:IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            self.ZhiChudataModel.ZhiChuList.remove(at: indexPath.row)
            self.tableView!.reloadData()
            print("你确认了删除按钮")
            ZhiChudataModel.saveData()
            tableView.reloadData()
        }
    }
    
    func imageForRating(rating:Int) -> UIImage? {
        switch rating {
        case 1:
            return UIImage(named: "1StarSmall")
        case 2:
            return UIImage(named: "2StarsSmall")
        case 3:
            return UIImage(named: "3StarsSmall")
        case 4:
            return UIImage(named: "4StarsSmall")
        case 5:
            return UIImage(named: "5StarsSmall")
        default:
            return nil
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ZhiChudataModel.ZhiChuList.count
    }
    
    
    @IBAction func cancelToZhiChuPlayersViewController(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveZhiChuAdd(segue:UIStoryboardSegue) {
        let ZhiChuAddTableViewController = segue.source as! ZhiChuAddTableViewController
        ZhiChudataModel.loadData()
        ZhiChudataModel.ZhiChuList.append(ZhiChuInfo(money: ZhiChuAddTableViewController.ZhiChuAddMoney.text!, message: ZhiChuAddTableViewController.ZhiChuAddMessage.text!, time: ZhiChuAddTableViewController.ZhiChuAddTime.text!, kind: "12"))
        ZhiChudataModel.saveData()
        //update the tableView
        //let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
        
        let indexPath=NSIndexPath(row: ZhiChudataModel.ZhiChuList.count-1, section: 0)
        tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        
        //hide the detail view controller
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZhiChuCell", for: indexPath as IndexPath) as UITableViewCell //1
        let player = ZhiChudataModel.ZhiChuList[indexPath.row] as ZhiChuInfo //2
        if let ZhiChumessagelabel = cell.viewWithTag(120) as? UILabel { //3
            ZhiChumessagelabel.text = player.message
        }
        if let ZhiChutimelabel = cell.viewWithTag(121) as? UILabel {
            ZhiChutimelabel.text = player.time
        }
        if let ZhiChumoneylabel = cell.viewWithTag(122) as? UILabel {
            //let date = NSDate()
            //let timeFormatter = DateFormatter()
            //timeFormatter.dateFormat = "yyy-MM-dd"
            //let strNowTime = timeFormatter.string(from: date as Date) as String
            //timelabel.text=strNowTime
            ZhiChumoneylabel.text=player.money
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ZhiChuShowDetails"{
            let controller = segue.destination as! ZhiChuDetailsTableViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                controller.ZhiChuitemString=ZhiChudataModel.ZhiChuList[indexPath.row].money
                controller.ZhiChuitemString2 = ZhiChudataModel.ZhiChuList[indexPath.row].kind
                controller.ZhiChuitemString3 = ZhiChudataModel.ZhiChuList[indexPath.row].message
                controller.ZhiChuitemString4 = ZhiChudataModel.ZhiChuList[indexPath.row].time
                controller.ZhiChuhangshu=indexPath.row
            }
        }
    }
    
    
    
    
    @IBAction func AlterZhiChuDetailView(segue:UIStoryboardSegue) {
        let ZhiChuDetailsTableViewController = segue.source as! ZhiChuDetailsTableViewController
        ZhiChudataModel.ZhiChuList[ZhiChuDetailsTableViewController.ZhiChuhangshu!] = ZhiChuInfo(money: ZhiChuDetailsTableViewController.ZhiChuDetailMoney.text!, message: ZhiChuDetailsTableViewController.ZhiChuDetailMessage.text!, time: ZhiChuDetailsTableViewController.ZhiChuDetailTime.text!, kind: "22")
        dismiss(animated: true, completion: nil)
        ZhiChudataModel.saveData()
        tableView.reloadData()
    }
    

   }
