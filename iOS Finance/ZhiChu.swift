//
//  ZhiChu.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/4.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import Foundation
class ZhiChuInfo: NSObject,NSCoding{
    var money: String
    var message: String
    var time:String
    var kind:String
    
    init(money:String="",message:String="",time:String="",kind:String="")
    {
        self.money = money
        self.message = message
        self.time=time
        self.kind=kind
        super.init()
    }
    
    required init(coder aDecoder:NSCoder!)
    {
        self.money=aDecoder.decodeObject(forKey: "Money") as! String
        self.message=aDecoder.decodeObject(forKey: "Message") as! String
        self.time=aDecoder.decodeObject(forKey: "Time") as! String
        self.kind=aDecoder.decodeObject(forKey: "Kind") as! String
    }
    func encode(with aCoder: NSCoder!)
    {
        aCoder.encode(money, forKey: "Money")
        aCoder.encode(message, forKey: "Message")
        aCoder.encode(time, forKey: "Time")
        aCoder.encode(kind, forKey: "Kind")
        
    }
}
