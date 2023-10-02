//
//  drinksCo2CalculationsAndTips.swift
//  EcoStep1
//
//  Created by Федор on 08.03.2022.
//

import Foundation

class drinksTips{
    let coffeeList = ["COAmericano","COCappuccino","COEspresso","COBlack Coffee","COFlat White","COLatte","COMocha"]
    
    let juicesList = ["JUApple Juice","JUOrange Juice","JUGrapefruit Juice","JUFruit Juice","JULime Juice","JUPineapple Juice"]
    
    let teaList = ["TEBlack Tea","TEGreen Tea","TEHerbal Tea","TEJasmin Tea"]
    
    let lowestEmission = ["COBlack Coffee","COAmericano","JULime Juice","TEJasmin Tea"]
    
    let drinkEmissionClass = drinksEmission()
    
    func returnFullTipsArrayForDrinks()->Array<String>{
        var drinksTips:Array<String> = []
        
        let drinks = allDrinks
        
        var alreadyAdvised:Array<String> = []
        
        var possiblePhrases:Array<String> = []
        
        var drinkWithLowerEmission:String
        
        for i in 0..<drinks.count{
            
            let choosenForTipDrink = drinks[i]
            
            if lowestEmission.contains(choosenForTipDrink) == false{
                
                drinkWithLowerEmission = drinkEmissionClass.getItemsForDrinkTip(drinkToChange: choosenForTipDrink)
                
                if alreadyAdvised.contains(choosenForTipDrink) == false {
                    possiblePhrases.append("DRT You should try drinking \(drinkWithLowerEmission.dropFirst(2)) instead of \(choosenForTipDrink.dropFirst(2))!")
                    possiblePhrases.append("DRT Drinking \(drinkWithLowerEmission.dropFirst(2)) instead of \(choosenForTipDrink.dropFirst(2)) will decrease your emission!")
                    possiblePhrases.append("DRT Drinking \(drinkWithLowerEmission.dropFirst(2)) instead of \(choosenForTipDrink.dropFirst(2)) is more eco-friendly!")
                    
                    drinksTips.append(possiblePhrases.randomElement()!)
                    
                    alreadyAdvised.append(choosenForTipDrink)
                }
                
                
            }
            
        }
        
        return drinksTips
    }
    
    
    
}

class drinksEmission{
    
    let drinksEmission = [
        "COAmericano":0.7,
        "COCappuccino":1.6,
        "COEspresso":0.71,
        "COBlack Coffee":0.7,
        "COFlat White":1.61,
        "COLatte":1.61,
        "COMocha":1.61,
        
        "JUApple Juice":2.4,
        "JUOrange Juice":2.0,
        "JUGrapefruit Juice":2.06,
        "JUFruit Juice":1.71,
        "JULime Juice":0.62,
        "JUPineapple Juice":2.52,
        
        "TEBlack Tea":0.61,
        "TEGreen Tea":0.63,
        "TEHerbal Tea":0.63,
        "TEJasmin Tea":0.6
    ]
    
    
    func getItemsForDrinkTip(drinkToChange:String)->String{
        var arrayWithSuitableFood: Array<String> = []
        
        let drinkTipClass = drinksTips()
        
        switch drinkToChange.prefix(2){
        case "CO":
            arrayWithSuitableFood = loopTHroughDrinkList(drinkForTip: drinkToChange, drinkArray: drinkTipClass.coffeeList)
        case "JU":
            arrayWithSuitableFood = loopTHroughDrinkList(drinkForTip: drinkToChange, drinkArray: drinkTipClass.juicesList)
        case "TE":
            arrayWithSuitableFood = loopTHroughDrinkList(drinkForTip: drinkToChange, drinkArray: drinkTipClass.teaList)
        default:
            print("error")
        }
        
        return arrayWithSuitableFood.randomElement()!
    
    }
    
    func loopTHroughDrinkList(drinkForTip:String,drinkArray:Array<String>)->Array<String>{
        var finalDrinkArray:Array<String> = []
        
        let choosenDrinkFootprint = drinksEmission[drinkForTip]
        
        for i in 0..<drinkArray.count{
            if drinksEmission[drinkArray[i]]! < choosenDrinkFootprint!{
                finalDrinkArray.append(drinkArray[i])
            }
        }
        
        return finalDrinkArray
    }
    
    func getFootprint(choosenDrink:String,drinkVolume:Double)->Double{
        var emission = 0.0
        
        emission = drinksEmission[choosenDrink] ?? 0.0 * drinkVolume
        
        return emission
        
    }
    func getFootprintForDrinks()->Double{
        var fullemission = 0.0
        for i in 0..<allDrinks.count{
            fullemission += Double(drinksEmission[allDrinks[i] ] ?? 0.0) * Double((allDrinksVolume[i]))
        }
        fullemission = Double(round(100 * fullemission) / 100)
        return fullemission
    }
    
    
}
