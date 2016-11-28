//
//  ShouRuKind.swift
//  iOS Finance
//
//  Created by dawen wang on 16/11/1.
//  Copyright © 2016年 dawen wang. All rights reserved.
//

import Foundation
class ShouRuKindInfo: NSObject,NSCoding{

    var skind:String
    
    init(skind:String="")
    {
 
        self.skind=skind
        super.init()
    }
    
    required init(coder aDecoder:NSCoder!)
    {
                self.skind=aDecoder.decodeObject(forKey: "SKind") as! String
    }
    func encode(with aCoder: NSCoder!)
    {
       
        aCoder.encode(skind, forKey: "SKind")
        
    }
}
