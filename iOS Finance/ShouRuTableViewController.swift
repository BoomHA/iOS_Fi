//
//  ShouRuTableViewController.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/1.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit

class ShouRuTableViewController: UITableViewController {

    var dataModel = ShouRuDataModel()
    
    @IBOutlet weak var money: UILabel!
    @IBAction func editBarBtnClick(_ sender: UIBarButtonItem) {
        
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
        dataModel.loadData()
        tableView.reloadData()
    }
    
   
    ///在编辑状态，可以拖动设置cell位置
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    ///移动cell事件
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath,to toIndexPath: IndexPath) {
        if fromIndexPath != toIndexPath{
            //获取移动行对应的值
            let itemValue:ShouRuInfo = dataModel.ShouruList[fromIndexPath.row]
            //删除移动的值
            dataModel.ShouruList.remove(at: fromIndexPath.row)
            //如果移动区域大于现有行数，直接在最后添加移动的值
            if toIndexPath.row > dataModel.ShouruList.count{
                dataModel.ShouruList.append(itemValue)
            }else{
                //没有超过最大行数，则在目标位置添加刚才删除的值
                dataModel.ShouruList.insert(itemValue, at:toIndexPath.row)
            }
            dataModel.saveData()
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
            self.dataModel.ShouruList.remove(at: indexPath.row)
            self.tableView!.reloadData()
            print("你确认了删除按钮")
            dataModel.saveData()
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

    
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailView"{
            let controller = segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                controller.itemString=dataModel.userList[indexPath.row].title
                //controller.itemString = dataModel[indexPath.row].title
                controller.itemString2 = dataModel.userList[indexPath.row].message
                controller.itemString3 = dataModel.userList[indexPath.row].time
                controller.hangshu=indexPath.row
            }
        }
    }*/


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.ShouruList.count
    }

    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveShouRuAdd(segue:UIStoryboardSegue) {
        let ShouRuAddTableViewController = segue.source as! ShouRuAddTableViewController
        dataModel.ShouruList.append(ShouRuInfo(money: ShouRuAddTableViewController.addmoeney.text!, message: ShouRuAddTableViewController.addmessage.text!, time: ShouRuAddTableViewController.addtime.text!, kind: "765"))
        //update the tableView
        //let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
        
        let indexPath=NSIndexPath(row: dataModel.ShouruList.count-1, section: 0)
        tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        
        //hide the detail view controller
        dismiss(animated: true, completion: nil)
        
        dataModel.saveData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShouRuDetailView"{
            let controller = segue.destination as! ShouRuDetailsTableViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                controller.itemString=dataModel.ShouruList[indexPath.row].money
                //controller.itemString = dataModel[indexPath.row].title
                controller.itemString2 = dataModel.ShouruList[indexPath.row].kind
                controller.itemString3 = dataModel.ShouruList[indexPath.row].message
                controller.itemString4 = dataModel.ShouruList[indexPath.row].time
                controller.hangshu=indexPath.row
            }
        }
        
        
    }
    
    
    @IBAction func AlterDetailView(segue:UIStoryboardSegue) {
        let ShouRuDetailsTableViewController = segue.source as! ShouRuDetailsTableViewController
    
        //add the new player to the players array

        dataModel.ShouruList[ShouRuDetailsTableViewController.hangshu!] = ShouRuInfo(money: ShouRuDetailsTableViewController.ShouRuDetailMoney.text!, message: ShouRuDetailsTableViewController.ShouRuDetailMessage.text!, time: ShouRuDetailsTableViewController.ShouRuDetailTime.text!, kind: "fds")
        //update the tableView
        //let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
        //hide the detail view controller
        dismiss(animated: true, completion: nil)
        dataModel.saveData()
        tableView.reloadData()
    }
    

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShouRuCell", for: indexPath as IndexPath) as UITableViewCell //1
        let player = dataModel.ShouruList[indexPath.row] as ShouRuInfo //2
        if let messagelabel = cell.viewWithTag(100) as? UILabel { //3
            messagelabel.text = player.message
        }
        if let timelabel = cell.viewWithTag(101) as? UILabel {
            timelabel.text = player.time
        }
        if let moneylabel = cell.viewWithTag(102) as? UILabel {
            //let date = NSDate()
            //let timeFormatter = DateFormatter()
            //timeFormatter.dateFormat = "yyy-MM-dd"
            //let strNowTime = timeFormatter.string(from: date as Date) as String
            //timelabel.text=strNowTime
            moneylabel.text=player.money
        }
        return cell
    }
    
    

    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
