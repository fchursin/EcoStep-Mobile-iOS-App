//
//  foodCo2CalcualtionsAndTips.swift
//  EcoStep1
//
//  Created by Федор on 27.01.2022.
//

import UIKit

class foodTips{
    
    let meatList = [
        "MELamb","MEBeef","MEChicken","MEPork","METurkey","MEBacon","MEGammon","MEGoat","MEHam","MERabbit"
    ]
    
    let eggsProductionList = [
        "EGScrambled eggs","EGEggs"
    ]
    
    let fishList = [
        "FISalmon","FITrout","FISardines","FITuna","FISeabass","FIAnchovies","FIHalibut"
    ]
    
    let seaFoodList = [
        "SEShrimps","SEMussels","SEOysters","SELobster","SEScampi","SEClams"
    ]
    
    let dairyList = [
        "DAMilk","DAYougurt","DAQuark","DASour cream","DAButter"
    ]
    
    let cheesesList = [
        "CHCheese","CHMozzarella","CHParmesan","CHCamamber","CHCheddar","CHFeta","CHMascarpone"
    ]
    
    let vegetablesList = [
        "VECucumber","VETomato","VECarrot","VEPotato","VEAvocado","VEPeas","VECorn","VEBroccoli","VEArtichoke","VEAsparagus","VECauliflower","VELettuce","VECabbage"
    ]
    
    let fruitsList = [
        "FRApple","FRBanana","FROrange","FRPear","FRKiwi","FRWatermelon","FRGrape","FRStrawberry","FRApricot","FRCherries","FRLemons","FRLime","FRMangoes","FRPapaya"
    ]
    
    let sideDishesList = [
        "SDSalad","SDMashed potatoes","SDPasta products","SDRice"
    ]
    
    let pastaList = [
        "PAChicken noodles","PABoognese","PATomato pasta","PABeef lasagne"
    ]
    
    let meatBasedFoodList = [
        "MBChicken roast","MBLamb curry","MBLamb roast","MBPork with rice","MBChicken curry"
    ]
    
    let cerealsList = [
        "CEOats","CEMuesli","CEQuinoa","CEBarley","CEBulgar","CELentils","CEPolenta","CEWheat","CEBuckwheat"
    ]
    
    let lowestFootprintFood = [
        "MEChicken","MESausages","EGEggs","FISardines","SEMussel","CHCamamber","CHFeta","VEGarlic","VEArtichoke","FRApple","SDRice","PATomato pasta","MBChicken roast","CEWheat","CEBuckwheat", "DAMilk","DAYougurt","DAQuark","DASour cream","DAButter","CHMozzarella"
    ]
    
    let foodEmissionClass = foodEmmission()
    
    func returnArrayWithTips()->Array<String>{
        var foodTips:Array<String> = []
        
//        var amountOfActualFoodTips = amountOfPreferedFoodTips
      
        var usedMeals = foodForMeals
        
        var possiblePhrases:Array<String> = []
        
        var advisedFood:Array<String> = []
        
        for j in 0..<usedMeals.count{
            
            var actualMealType:Array<String> = usedMeals[j] as! Array<String>
            
//            actualMealType = sortFoodAndDeleteWithLowestEmission(usedFood: actualMealType)
            
//            actualMealType = deleteDuplicates(usedFood: actualMealType)
            
   
        
            for i in 0..<actualMealType.count{
                
                
                    possiblePhrases = []
                    
                    var foodWithLowerEmission:String
                    
                    let choosenForTipFood = actualMealType[i]
                
                if lowestFootprintFood.contains(choosenForTipFood) == false{
                    
                    foodWithLowerEmission = foodEmissionClass.getItemsForFoodTip(foodToChange: choosenForTipFood)
                    
//                    advisedFood.append(choosenForTipFood)
                    
                    if advisedFood.contains(choosenForTipFood) == false {
                        possiblePhrases.append("FOT You should try eating \(foodWithLowerEmission.dropFirst(2)) instead of \(choosenForTipFood.dropFirst(2))!")
                        possiblePhrases.append("FOT Eating \(foodWithLowerEmission.dropFirst(2)) instead of \(choosenForTipFood.dropFirst(2)) will decrease your emission!")
                        possiblePhrases.append("FOT Eating \(foodWithLowerEmission.dropFirst(2)) instead of \(choosenForTipFood.dropFirst(2)) is more eco-friendly!")
                        
                        foodTips.append(possiblePhrases.randomElement()!)
                     
                        advisedFood.append(choosenForTipFood)
                    }
                }
            }
        }
        return foodTips
    }
    
    
    func deleteDuplicates(usedFood:Array<String>)->Array<String>{
        var allFoodArray = usedFood
        
        var alreadyCheckedFood:Array<String> = []
        
        var nummers:Array<Int> = []
        
        for i in 0..<allFoodArray.count{
            if alreadyCheckedFood.contains(allFoodArray[i]){
                nummers.append(i-nummers.count)
            }
            else{
                alreadyCheckedFood.append(allFoodArray[i])
            }
        }
        for j in 0..<nummers.count{
            allFoodArray.remove(at: j)
        }
        
        return allFoodArray
    }
    
    func sortFoodAndDeleteWithLowestEmission(usedFood:Array<String>)->Array<String>{
            
            var foodArr = usedFood
        
            var nummers:Array<Int> = []

            for i in 0..<foodArr.count{
                if lowestFootprintFood.contains(usedFood[i]){
                    nummers.append(i-nummers.count)
                }
            }

            for j in 0..<nummers.count{
                foodArr.remove(at: nummers[j])
            }
           
        
        
        return foodArr
    }
}
    


class foodEmmission{
    let foodEmission = [
        "MELamb":24.0,
        "MEBeef":39.0,
        "MEChicken":6.0,
        "MEPork":7.0,
        "MESausages":6.0,
        "METurkey":6.5,
        "MEBacon":6.6,
        "MEGammon":6.6,
        "MEGoat":35.7,
        "MEHam":6.6,
        "MERabbit":11.1,
        
        "EGScrambled eggs":7.5,
        "EGEggs":5.0,
        
        "FISalmon":2.9,
        "FITrout":4.3,
        "FISardines":0.75,
        "FITuna":6.1,
        "FISeabass":4.3,
        "FIAnchovies":4.7,
        "FIHalibut":4.3,
        
        "SEShrimps":12.0,
        "SEMussels":0.43,
        "SEOysters":8.1,
        "SELobster":15.5,
        "SEScampi":17.7,
        "SEClams":3.1,
        
        "DAMilk":3.0,
        "DAYougurt":2.92,
        "DAQuark":0.26,
        "DASour cream":17.0,
        "DAButter":9.4,
        
        "CHCheese":13.5,
        "CHMozzarella":6.66,
        "CHParmesan":8.8,
        "CHCamamber":7.1,
        "CHCheddar":7.4,
        "CHFeta":7.1,
        "CHMascarpone":7.5,
        
        "VECucumber":1.9,
        "VETomato":2.9,
        "VECarrot":1.3,
        "VEPotato":1.2,
        "VEAvocado":2.4,
        "VEPeas":4.2,
        "VECorn":0.4,
        "VEBroccoli":1.1,
        "VEArtichoke":0.3,
        "VEAsparagus":7.1,
        "VECauliflower":0.97,
        "VEGarlic":0.4,
        "VELettuce":1.6,
        "VECabbage":0.62,
        
        "FRApple":0.250,
        "FRBanana":1.5,
        "FROrange":0.375,
        "FRPear":0.35,
        "FRKiwi":0.59,
        "FRWatermelon":0.8,
        "FRGrape":0.45,
        "FRStrawberry":1.2,
        "FRApricot":0.4,
        "FRCherries":2.8,
        "FRLemons":1.2,
        "FRLime":1.9,
        "FRMangoes":4.4,
        "FRPapaya":4.4,
        
        "SDSalad":3.2,
        "SDMashed potatoes":1.6,
        "SDPasta products":1.4,
        "SDRice":1.1,
        
        "PAChicken noodles":7.5,
        "PABoognese":11.6,
        "PATomato pasta":4.7,
        "PABeef lasagne":13.8,
        
        "MBChicken roast":6.9,
        "MBLamb curry":13.6,
        "MBLamb roast":9.1,
        "MBPork with rice":7.7,
        "MBChicken curry":8.1,
        
        "CEOats":0.79,
        "CEMuesli":1.1,
        "CEQuinoa":0.8,
        "CEBarley":1.1,
        "CEBulgar":0.76,
        "CELentils":0.85,
        "CEPolenta":0.76,
        "CEWheat":0.71,
        "CEBuckwheat":0.71
    ]
    
  
    func getItemsForFoodTip(foodToChange:String)->String{
        var arrayWithSuitableFood: Array<String> = []
        
        let foodTipsClass = foodTips()
        
        switch foodToChange.prefix(2){
        case "CE":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.cerealsList)
        case "MB":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.meatBasedFoodList)
        case "PA":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.pastaList)
        case "SD":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.sideDishesList)
        case "FR":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.fruitsList)
        case "VE":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.vegetablesList)
        case "CH":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.cheesesList)
        case "DA":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.dairyList)
        case "SE":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.seaFoodList)
        case "FI":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.fishList)
        case "EG":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.eggsProductionList)
        case "ME":
            arrayWithSuitableFood = loopTHroughFoodList(foodForTip: foodToChange, foodArray: foodTipsClass.meatList)
            
        default:
            print("error")
        }
        
        return arrayWithSuitableFood.randomElement()!
    
    }
        
        func loopTHroughFoodList(foodForTip:String,foodArray:Array<String>)->Array<String>{
            var finalFoodArray:Array<String> = []
            
            let choosenFoodFootprint = foodEmission[foodForTip]
            
            for i in 0..<foodArray.count{
                if foodEmission[foodArray[i]]! < choosenFoodFootprint!{
                    finalFoodArray.append(foodArray[i])
                }
            }
            
            return finalFoodArray
        }
    
    func getFootprint(choosenMeal:String,mealWeight:Double)->Double{
        var emission = 0.0
        
        emission = foodEmission[choosenMeal] ?? 0.0 * mealWeight
        
        return emission
        
    }
    func getFootprintForCurrentMeal(mealType:Int)->Double{
        var fullemission = 0.0
        for i in 0..<foodForMeals[mealType].count{
            fullemission += Double(foodEmission[foodForMeals[mealType][i] as! String] ?? 0.0) * (weightForMeals[mealType][i] as! Double)
        }
        fullemission = Double(round(100 * fullemission) / 100)
        return fullemission
    }
    
    func getFootprintForAllMeals()->Double{
        var fullemission = 0.0
        for i in 0..<foodForMeals.count{
            for j in 0..<foodForMeals[i].count{
                fullemission += Double(foodEmission[foodForMeals[i][j] as! String] ?? 0.0) * (weightForMeals[i][j] as! Double)
            }
        }
        fullemission = Double(round(100 * fullemission) / 100)
        return fullemission
        
    }
}
class weightPerPiece{
    let weightPerPiece = [
        "MELamb":0.34,
        "MEBeef":0.34,
        "MEChicken":0.25,
        "MEPork":0.34,
        "MESausages":0.11,
        "METurkey":0.23,
        "MEBacon":0.015,
        "MEGammon":0.085,
        "MEGoat":0.34,
        "MEHam":0.34,
        "MERabbit":0.34,
        
        "FISalmon":0.34,
        "FITrout":0.28,
        "FISardines":0.085,
        "FITuna":0.4,
        "FISeabass":0.198,
        "FIAnchovies":0.045,
        "FIHalibut":0.16,
        
        "SEShrimps":0.085,
        "SEMussels":0.45,
        "SEOysters":0.1,
        "SELobster":0.12,
        "SEScampi":0.075,
        "SEClams":0.085,
        
        "DAYougurt":0.225,
        "DAQuark":0.14,
        "DASour cream":0.24,
        "DAButter":0.225,
        
        "FRApple":0.195,
        "FRBanana":0.120,
        "FROrange":0.130,
        "FRPear":0.180,
        "FRKiwi":0.075,
        "FRWatermelon":9.0,
        "FRGrape":0.005,
        "FRStrawberry":0.012,
        "FRApricot":0.035,
        "FRCherries":0.005,
        "FRLemons":0.1,
        "FRLime":0.05,
        "FRMangoes":0.2,
        "FRPapaya":0.45,
        
        "VECucumber":0.25,
        "VETomato":0.17,
        "VECarrot":0.06,
        "VEPotato":0.184,
        "VEAvocado":0.17,
        "VEPeas":0.005,
        "VECorn":0.18,
        "VEBroccoli":0.225,
        "VEArtichoke":0.368,
        "VEAsparagus":0.022,
        "VECauliflower":0.5,
        "VEGarlic":0.06,
        "VELettuce":0.8,
        "VECabbage":9.07,
        
        "EGEggs":0.060,
        "EGScrambled eggs":0.09,
        
        "SDSalad":0.1,
        "SDMashed potatoes":0.21,
        "SDPasta products":0.125,
        "SDRice":0.125,
        
        "PAChicken noodles":0.2,
        "PABoognese":0.2,
        "PATomato pasta":0.2,
        "PABeef lasagne":0.2,
        
        "CEOats":0.157,
        "CEMuesli":0.157,
        "CEQuinoa":0.185,
        "CEBarley":0.157,
        "CEBulgar":0.157,
        "CELentils":0.198,
        "CEPolenta":0.125,
        "CEWheat":0.1,
        "CEBuckwheat":0.17
        
    ]
}

