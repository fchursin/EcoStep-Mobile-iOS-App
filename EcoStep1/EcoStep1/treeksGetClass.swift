//
//  treeksGetClass.swift
//  EcoStep1
//
//  Created by Федор on 27.03.2022.
//

import UIKit


var allActions:Array<String> = []

class treeksGetClass{
    
    func getTreeksPercentage()->Double{
        var actionsArr = saveDef.stringArray(forKey: "allActions") ?? []
     
        var drinks:Int = 0
        for i in 0..<actionsArr.count{
            if actionsArr[i] == "Drink"{
                drinks += 1
            }
        }
        if drinks>3{
            drinks = 3
            
        }
        actionsArr = Array(Set(actionsArr))
 
        
        actionsArr = actionsArr.filter{$0 != "Drink"}
       
        let allLeftActions = actionsArr.count
        
     
        
        return Double(allLeftActions+drinks)/9.0
    }
}
