//
//  ZhiChuKindViewTableViewController.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/9.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import UIKit

class ZhiChuKindViewTableViewController: UITableViewController,UIGestureRecognizerDelegate{

    var ShouRukinddata=ShouRuKindDataModel()
    
    var savekind:String!
    var selectedIndex: Int!

    @IBAction func KindAlter(_ sender: UIBarButtonItem) {
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
    @IBAction func addclass(_ sender: AnyObject) {
        let alert = UIAlertController(title: "添加类别", message: "请输入类别名", preferredStyle: .alert)
        alert.addTextField {
            (UITextField) in
            UITextField.becomeFirstResponder()
            UITextField.returnKeyType = .done
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
            if alert.textFields?.first?.text != "" {
                self.ShouRukinddata.ShouruKindList.append(ShouRuKindInfo(skind: (alert.textFields?.first?.text)!))
                self.ShouRukinddata.saveData()
                self.tableView.reloadData()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(LongPress))
        longPress.delegate = self
        longPress.minimumPressDuration = 0.5
        self.tableView.addGestureRecognizer(longPress)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        ShouRukinddata.loadData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
                ShouRukinddata.ShouruKindList.remove(at: indexPath.row)
                ShouRukinddata.saveData()
                self.tableView.reloadData()
                self.tableView.setEditing(true, animated: true)
            }
            else{
                let alert = UIAlertController(title: "警告", message: "该类别已被选中，无法删除", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.tableView.setEditing(true, animated: true)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let content = ShouRukinddata.ShouruKindList[sourceIndexPath.row]
        ShouRukinddata.ShouruKindList.remove(at: sourceIndexPath.row)
        ShouRukinddata.ShouruKindList.insert(content, at: destinationIndexPath.row)
        ShouRukinddata.saveData()
    }
    
    func LongPress(gestureRecongnizer:UILongPressGestureRecognizer) {
        if gestureRecongnizer.state == UIGestureRecognizerState.began {
            
        }
        if gestureRecongnizer.state == UIGestureRecognizerState.ended {
            if self.tableView.isEditing == false {
                self.tableView.setEditing(true, animated: true)
            }
            else{
                self.tableView.setEditing(false, animated: true)
            }
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShouRukinddata.ShouruKindList.count
    }
    
    
    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func SaveShouruKindAdd(segue:UIStoryboardSegue) {
        let ShouRuKindAddTableViewController = segue.source as! ShouRuKindAddTableViewController
        //add the new player to the players array
        ShouRukinddata.ShouruKindList.append(ShouRuKindInfo(skind: ShouRuKindAddTableViewController.ShouRukindaddtext.text!))
        //update the tableView
        //let indexPath = NSIndexPath(forRow: players.count-1, inSection: 0)
        
        let indexPath=NSIndexPath(row: ShouRukinddata.ShouruKindList.count-1, section: 0)
        tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        //hide the detail view controller
        dismiss(animated: true, completion: nil)
        
        ShouRukinddata.saveData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShouRuKindCell", for: indexPath as IndexPath) as UITableViewCell //1
        let player = ShouRukinddata.ShouruKindList[indexPath.row] as ShouRuKindInfo //2
        if let kindlabel = cell.viewWithTag(1) as? UILabel { //3
            kindlabel.text = player.skind
        }
        return cell
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ShouRukinddata.loadData()
        savekind = ShouRukinddata.ShouruKindList[indexPath.row].skind
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedZhichuAdd" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            selectedIndex = indexPath?.row
            ShouRukinddata.loadData()
            savekind = ShouRukinddata.ShouruKindList[selectedIndex].skind
            
        }
    }

    
}
