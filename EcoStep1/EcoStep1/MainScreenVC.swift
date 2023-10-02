//
//  MainScreenVC.swift
//  EcoStep1
//
//  Created by Федор on 18.12.2021.
//

import UIKit

import Firebase

var treeks = 0

let saveDef = UserDefaults.standard

var shouldEcoStepiBeShown = true

class mainScreenVC: UIViewController{
    
    func setAllArrays(){
        routeLength = (saveDef.array(forKey: "allRoutesLengthArray") ?? [[],[],[],[],[]]) as! Array<Array<Any>>
        foodForMeals = (saveDef.array(forKey: "foodForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        weightForMeals = (saveDef.array(forKey: "wieghtForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        allDrinks = saveDef.stringArray(forKey: "allDrinks") ?? []
        allDrinksVolume = (saveDef.array(forKey: "allDrinksVolumeArray") ?? []) as! Array<Float>
    }
    
    func setTreeksManAmount(){
        let userId = Auth.auth().currentUser!.uid
        
        let referenceToAllUsers = db.collection("ids").document("userIds")
        
        referenceToAllUsers.getDocument { (document, error) in
            
            if let document = document {
                
                let data = document.data()
                self.arrayWithIds =  data!["allIds"] as! Array<String>
                
                if self.arrayWithIds.contains(userId) == true {
                    
                    let docRef = self.db.collection("usersInfo").document("\(userId)")
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data() as! Dictionary<String,Any>
                            saveDef.set(dataDescription["drinksManAmount"], forKey: "drinksMan")
                            saveDef.set(dataDescription["housingManAmount"], forKey: "housingMan")
                            saveDef.set(dataDescription["transportingManAmount"], forKey: "transportMan")
                            saveDef.set(dataDescription["drinksMan"], forKey: "isDrinkTipAvailable")
                            saveDef.set(dataDescription["treeksAmount"], forKey: "treeks")
                            saveDef.set(dataDescription["transportMan"], forKey: "isTransportTipAvailable")
                            saveDef.synchronize()
                            self.treeksLabel.text = "\(saveDef.integer(forKey: "treeks")) Treeks"
                        } else {
                            print("Document does not exist")
                        }
                    }
                } else {
              print("Document does not exist in cache")
            }
          }
        }
    }
    let backgroundViewFirst = UIView()
    
    let whiteView = UIView()
    
    var stepCounter = 0
    
    var savedDate = ""

    let footrpintClass = wholeFootprintCalculations()
    
    let tipsClass = arrangeTipsAndImages()
    
    let dateClassRef = dateClass()
    
    @IBOutlet weak var footprintImage: UIImageView!
    @IBOutlet weak var co2Number: UILabel!
    
    @IBOutlet weak var whiteBoard: UIImageView!
    
    @IBOutlet weak var co2Label: UILabel!
    let db = Firestore.firestore()
    var arrayWithIds = [String]()
    
    
    
    @IBOutlet weak var sepBar: UIProgressView!
    
    @IBOutlet weak var tableRef: UIView!
    @IBOutlet weak var yourTreeksLabel: UILabel!
    @IBOutlet weak var treeksBg: UIImageView!
    @IBOutlet weak var treeksLogoImg: UIImageView!
    @IBOutlet weak var yourFootprintLabel: UILabel!
    @IBOutlet weak var treeksLabel: UILabel!
    @IBOutlet weak var treeImage: UIImageView!
    
    @IBOutlet weak var funEcoStep: UIImageView!
    
    
       
    override func viewDidAppear(_ animated: Bool) {
       
       print(UIDevice.current)
        
       if Auth.auth().currentUser == nil{
          performSegue(withIdentifier: "logInScreen", sender: self)
       }
       

        
       else if saveDef.bool(forKey: "firstLaunch") == false && Auth.auth().currentUser != nil{
            
    
            
            let userId = Auth.auth().currentUser!.uid
            
            let referenceToAllUsers = db.collection("ids").document("userIds")
            referenceToAllUsers.getDocument { (document, error) in
                if let document = document {
                    let data = document.data()
                    self.arrayWithIds =  data!["allIds"] as! Array<String>
                    
                    if self.arrayWithIds.contains(userId) == true {
                        
                    }
                    else{
                        self.arrayWithIds.append(userId)
                        self.db.collection("usersInfo").document("\(userId)").setData([
                            "treeksAmount":0,
                            "housingManAmount":0,
                            "drinksManAmount":0,
                            "transportingManAmount":0,
                            "drinksMan":false,
                            "housingMan":false,
                            "transportMan":false,
                        ])
                        self.db.collection("ids").document("userIds").setData([
                            "allIds": self.arrayWithIds
                        ])
                    }
                  
                } else {
                  print("Document does not exist in cache")
                }
              }
            performSegue(withIdentifier: "onBoardSegue", sender: self)
            
        }
        
        if shouldEcoStepiBeShown == false{
            funEcoStep.isHidden = true
        }
        else{
            funEcoStep.isHidden = false
        }
    }
    
    func getTipsSettled(){
        let tipsAr = tipsClass.arrangeTipsAndImages(foodTipsAvailable: true, drinksTipsAvailable: saveDef.bool(forKey: "isDrinkTipAvailable"), transportTipsAvailable: saveDef.bool(forKey: "isTransportTipAvailable"))
      
        Tips = tipsAr[0]
        TipsCheckMark = [Bool](repeating: false, count: tipsAr[0].count)
        TipsImages = tipsAr[1]
        
    }
    
    func settleTipsIfSaved(){
        Tips = saveDef.stringArray(forKey: "tipsArray") ?? []
        TipsImages = saveDef.stringArray(forKey: "tipsImagesArray") ?? []
        TipsCheckMark = (saveDef.array(forKey: "tipsCheckMarkArray") ?? []) as! Array<Bool>
    }
    
    func setViewsPos(){
        whiteBoard.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*0.42745)
        treeImage.frame = CGRect(x: self.view.frame.midX-(self.view.frame.width*0.2584/2), y: self.view.frame.height*0.0491, width: self.view.frame.width*0.2584, height: whiteBoard.frame.height*0.624)
        footprintImage.frame = CGRect(x: self.view.frame.width*0.041, y: whiteBoard.frame.height * 0.5195, width: self.view.frame.width*0.3309, height: whiteBoard.frame.height*0.29765)
        co2Label.frame = CGRect(x: footprintImage.frame.midX-(footprintImage.frame.width*0.8686/2), y: footprintImage.frame.midY-(footprintImage.frame.height*0.18421/2), width: footprintImage.frame.width*0.8686, height: footprintImage.frame.height*0.18421)
       
        co2Number.frame = CGRect(x: co2Label.frame.midX-(self.view.frame.width*0.2512/2), y: whiteBoard.frame.height*0.37075, width: self.view.frame.width*0.2512, height: whiteBoard.frame.height*0.10966)
       
        sepBar.frame = CGRect(x: whiteBoard.frame.midX-(self.view.frame.width*0.90338/2), y: whiteBoard.frame.height*0.75979, width: self.view.frame.width*0.90338, height: 4)
        yourFootprintLabel.frame = CGRect(x: co2Number.frame.midX-(107/2), y: whiteBoard.frame.height*0.791122, width:107, height: whiteBoard.frame.height*0.0496)
       
       treeksLogoImg.frame = CGRect(x: self.view.frame.width*0.637681, y: co2Number.frame.midY - ((self.view.frame.width*0.314)/2), width: self.view.frame.width*0.314, height: self.view.frame.width*0.314)
       
//        treeksLogoImg.frame = CGRect(x: self.view.frame.width*0.637681, y: whiteBoard.frame.height*0.25587, width: self.view.frame.width*0.314, height: self.view.frame.width*0.314)
       
       
       
        treeksBg.frame = CGRect(x: treeksLogoImg.frame.midX-(self.view.frame.width*0.3309/2), y: footprintImage.frame.midY-(whiteBoard.frame.height*0.29765/2), width: self.view.frame.width*0.3309, height: whiteBoard.frame.height*0.29765)
        treeksLabel.frame = CGRect(x: treeksBg.frame.midX-(treeksBg.frame.width*0.9489/2), y: whiteBoard.frame.height*0.642297, width: treeksBg.frame.width*0.9489, height: treeksBg.frame.height*0.18421)
        yourTreeksLabel.frame = CGRect(x: treeksLabel.frame.midX-(91/2), y: whiteBoard.frame.height*0.79112271, width: 91, height: whiteBoard.frame.height*0.049608)
        tableRef.frame = CGRect(x: self.view.frame.width*0.08695, y: self.view.frame.height*0.390625, width: self.view.frame.width*0.8285, height: self.view.frame.height*0.51674)
        funEcoStep.frame = CGRect(x: self.view.frame.midX-(self.view.frame.width*0.48309/2), y: self.view.frame.height*0.5066, width: self.view.frame.width*0.48309, height: self.view.frame.width*0.48309)
    }
     
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//                if (segue.identifier == "SignupSegue") {
//                    DispatchQueue.main.async {
//                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "onBoardVC")
//                        self.show(vc, sender: self)
//                    }
//              }
//       else if (segue.identifier == "logInScreen"){
//          DispatchQueue.main.async {
//             let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//             let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
//             self.show(vc, sender: self)
//          }
//       }
        }

    
    override func viewWillAppear(_ animated: Bool) {
        
       if Auth.auth().currentUser != nil{
        
            setTreeksManAmount()
            
            
            setViewsPos()
            
            savedDate = saveDef.string(forKey: "dateToCheck") ?? ""
            
            treeks = saveDef.integer(forKey:"treeks")
           
        
            if dateClassRef.compareDate(date: savedDate) == false{
                    newDay()
            }
            setAllArrays()
            
            settleTipsIfSaved()
            
            currentPage = ""
         
            let co2Footprint = footrpintClass.getTheWholeFootprint()
            
            co2Number.text = "\(Double(round(10*co2Footprint)/10))"
            
            
            
            if shouldEcoStepiBeShown == false{
                funEcoStep.isHidden = true
            }
            else{
                funEcoStep.isHidden = false
            }
            
            setColorOfLabelAndTreeType()
        }
    }
    
    func setColorOfLabelAndTreeType(){
        let co2Footprint = footrpintClass.getTheWholeFootprint()
        
        if co2Footprint < 19{
            co2Number.textColor = UIColor(red: 0.357, green: 0.780, blue: 0.357, alpha: 1.0)
            treeImage.image = UIImage(named: "newTreeGreenVersion")
        }
        else if co2Footprint > 19 && co2Footprint < 25{
            co2Number.textColor = UIColor(red: 1.0, green: 0.780, blue: 0.357, alpha: 1.0)
            treeImage.image = UIImage(named: "newABitYellowTree")
        }
        else if co2Footprint>25 && co2Footprint<35{
            co2Number.textColor = UIColor(red: 0.914, green: 0.2, blue: 0.257, alpha: 1.0)
            treeImage.image = UIImage(named:"newRedTree")
        }
        else if co2Footprint>35{
            co2Number.textColor = UIColor(red: 0.914, green: 0.2, blue: 0.257, alpha: 1.0)
            treeImage.image = UIImage(named:"newDeadTree")
        }
    }
    
    func newDay(){
        //clean Tips Arrays
        Tips = []
        TipsImages = []
        TipsCheckMark = []
       
        // get new tips
        getTipsSettled()
        
        saveDef.set(Tips, forKey: "tipsArray")
        saveDef.set(TipsImages, forKey: "tipsImagesArray")
        saveDef.set(TipsCheckMark, forKey: "tipsCheckMarkArray")
        
        //clean other arrays and bools
        firstTreekAchieved = false
        secondTreekAchieved = false
        thirdTreekAchieved = false
        
        saveDef.set(firstTreekAchieved, forKey: "firstTreek")
        saveDef.set(secondTreekAchieved, forKey: "secondTreek")
        saveDef.set(thirdTreekAchieved, forKey: "thirdTreek")
        
        allDrinks = []
        allDrinksVolume = []
        
        saveDef.set(allDrinks, forKey: "allDrinks")
        saveDef.set(allDrinksVolume, forKey: "allDrinksVolumeArray")
        
        foodForMeals = [[],[],[],[]]
        weightForMeals = [[],[],[],[]]
        
        saveDef.set(foodForMeals, forKey: "foodForMealsArray")
        saveDef.set(weightForMeals, forKey: "wieghtForMealsArray")
        
        routeLength = [[],[],[],[],[]]
        
        saveDef.set(routeLength, forKey: "allRoutesLengthArray")
        
        tipsLimited = true
        
        saveDef.set(tipsLimited, forKey: "timpsLimitedBool")
        
        allActions = []
        saveDef.set(allActions, forKey: "allActions")
        
        let isAdAvailable = true
        saveDef.set(isAdAvailable, forKey: "isAdAvailable")
        
        let currentDate = dateClassRef.getDate()
        saveDef.set(currentDate, forKey: "dateToCheck")
        
        //create new date in database
        
        saveDef.synchronize()
    }
    
    }

class dateClass{
    
    func getDate()->String{
        var currentDate = ""
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        currentDate = formatter.string(from: date)
        return currentDate
    }
    
    func compareDate(date:String)->Bool{
        if date == getDate(){
            return true
        }
        else{
            return false
        }
    }
    
}

class arrangeTipsAndImages{
    
    let foodTipsClass = foodTips()
    
    let drinksTipsClass = drinksTips()
    
    let transportTipsClass = transportTips()
    
    func arrangeTipsAndImages(foodTipsAvailable:Bool, drinksTipsAvailable:Bool, transportTipsAvailable:Bool)->Array<Array<String>>{
        var tipsAndImagesArray:Array<Array<String>> = []
        
        var drinksTips:Array<String> = []
        
        var transportTips:Array<String> = []
        
        let foodTips = foodTipsClass.returnArrayWithTips()
        
  
        
        if drinksTipsAvailable==true{
        
            drinksTips = drinksTipsClass.returnFullTipsArrayForDrinks()
  
        }
        
        if transportTipsAvailable==true{

            transportTips = transportTipsClass.returnTransportTipsArray()
            
        }
        
        var tipsArray = foodTips + drinksTips + transportTips
        
        tipsArray = tipsArray.shuffled()
        
        var imagesArray:Array<String> = []
        
        for i in 0..<tipsArray.count{
            let currentTip = String(tipsArray[i]).prefix(4)
            
            switch currentTip{
            case "TRT ":
                imagesArray.append("ecocar")
            case "DRT ":
                imagesArray.append("ecocup")
            case "FOT ":
                imagesArray.append("cookieMan")
            default:
                print("error")
            }
        }
        
        tipsAndImagesArray.append(tipsArray)
        tipsAndImagesArray.append(imagesArray)
        
        return tipsAndImagesArray
    }
    
    
}
