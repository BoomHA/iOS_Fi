//
//  ZhiChuData.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/4.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import Foundation
class ZhiChuDataModel: NSObject {
    var ZhiChuList=[ZhiChuInfo]()
    override init(){
        super.init()
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath())")
    }
    func saveData(){
        let data=NSMutableData()
        let archiver=NSKeyedArchiver(forWritingWith: data)
        archiver.encode(ZhiChuList, forKey: "ZhiChuList")
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    func loadData(){
        let path=self.dataFilePath()
        let defaultManager=FileManager()
        if defaultManager.fileExists(atPath: path)
        {
            let data = NSData(contentsOfFile: path)
            let unarchiver=NSKeyedUnarchiver(forReadingWith: data! as Data)
            ZhiChuList=unarchiver.decodeObject(forKey: "ZhiChuList") as! Array
            unarchiver.finishDecoding()
        }
        
    }
    func documentsDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentationDirectory,FileManager.SearchPathDomainMask.userDomainMask,true)
        let documentsDirectory:String = paths.first! as String
        return documentsDirectory
    }
    
    func dataFilePath ()->String{
        return self.documentsDirectory().appending("ZhiChuList.plist")
    }
}
