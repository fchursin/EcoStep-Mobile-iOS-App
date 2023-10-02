//
//  transportationActionVC.swift
//  EcoStep1
//
//  Created by Федор on 30.12.2021.
//

import UIKit
import Firebase

var shouldSegueToMApBePerformed = false

class transportationActionVC:UIViewController{
    @IBOutlet weak var zeroToTTPercentImage: UIImageView!
    @IBOutlet weak var ttTofiftyPercentImahe: UIImageView!
    @IBOutlet weak var toHundreedPercentImage: UIImageView!
    
    @IBOutlet weak var zeroToTTPercentView: UIView!
    @IBOutlet weak var ttToFiftuPercentView: UIView!
    @IBOutlet weak var toHudreedPercentView: UIView!
    
    @IBOutlet weak var firsSeparator: UIView!
    @IBOutlet weak var secondSeparator: UIView!
    
    @IBOutlet weak var uiView: UIView!
    
    @IBOutlet weak var getTreeksLabel: UILabel!
    @IBOutlet weak var transportationLabel: UILabel!
    
    @IBOutlet weak var thirdTreekLabel: UILabel!
    @IBOutlet weak var secondTreekLabel: UILabel!
    @IBOutlet weak var firstTreekLabel: UILabel!
    var progressPerPercent = 3.5
    let treeksClass = treeksGetClass()
    
    let db = Firestore.firestore()
    
    var firstWhiteProgressViewWidth = 90.0
    var firstWhiteProgressViewXPos = 32.0
    
    var secondWhiteProgressViewWidth = 90.0
    var secondWhiteProgressViewXPos = 122.0
    
    var thirdWhiteProgressViewWidth = 170.0
    var thirdWhiteProgressViewXpos = 212.0
    
    var firstSepWidth = 5.0
    var firstSepXpos = 117.0
    
    var secondSepWidth = 5.0
    var secondSepXpos = 212.0
    
    var firstWhiteProgressImageWidth = 85.0
    var firstWhiteProgressImageXPos = 32.0
    
    var secondWhiteProgressImageWidth = 90.0
    var secondWhiteProgressImageXPos = 122.0
    
    var thirdWhiteProgressImageWidth = 165.0
    var thirdWhiteProgressImageXpos = 217.0
    
    var savedDate = ""
    
    let tipsClass = arrangeTipsAndImages()
    
    let dateClassRef = dateClass()
    
    var timer = Timer()
    
    func setArraysForTransport(){
        
        routeLength = (saveDef.array(forKey: "allRoutesLengthArray") ?? [[],[],[],[],[]]) as! Array<Array<Any>>
        
    }
    
    func layoutAllViews(){
        uiView.frame = CGRect(x:0.06280193236714976*self.view.frame.width, y:0.2857142857142857*self.view.frame.height, width:0.8743961352657005*self.view.frame.width,height:0.6506696428571429*self.view.frame.height)
        
        zeroToTTPercentImage.frame = CGRect(x:0.07729468599033816*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.20531400966183574*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        firstWhiteProgressImageWidth = 0.20531400966183574*self.view.frame.width
        firstWhiteProgressImageXPos = 0.06280193236714976*self.view.frame.width

        ttTofiftyPercentImahe.frame = CGRect(x:0.2946859903381642*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.21739130434782608*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        secondWhiteProgressImageWidth = 0.21739130434782608*self.view.frame.width
        secondWhiteProgressImageXPos = 0.2946859903381642*self.view.frame.width
        
        toHundreedPercentImage.frame = CGRect(x:0.5241545893719807*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.39855072463768115*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        thirdWhiteProgressImageWidth = 0.39855072463768115*self.view.frame.width
        thirdWhiteProgressImageXpos = 0.5241545893719807*self.view.frame.width
        
        zeroToTTPercentView.frame = CGRect(x:0.07729468599033816*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.21739130434782608*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        firstWhiteProgressViewWidth = 0.21739130434782608*self.view.frame.width
        firstWhiteProgressViewXPos = 0.07729468599033816*self.view.frame.width
        
        ttToFiftuPercentView.frame = CGRect(x:0.2946859903381642*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.21739130434782608*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        secondWhiteProgressViewWidth = 0.21739130434782608*self.view.frame.width
        secondWhiteProgressViewXPos = 0.2946859903381642*self.view.frame.width

        toHudreedPercentView.frame = CGRect(x:0.5120772946859904*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.4106280193236715*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        thirdWhiteProgressViewWidth = 0.21739130434782608*self.view.frame.width
        thirdWhiteProgressViewXpos = 0.2946859903381642*self.view.frame.width
        
        firsSeparator.frame = CGRect(x:0.2826086956521739*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.012077294685990338*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        firstSepWidth = 0.012077294685990338*self.view.frame.width
        firstSepXpos = 0.2826086956521739*self.view.frame.width
        
        secondSeparator.frame = CGRect(x:0.5120772946859904*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.012077294685990338*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        secondSepWidth = 0.012077294685990338*self.view.frame.width
        secondSepXpos = 0.5120772946859904*self.view.frame.width
        
        getTreeksLabel.frame = CGRect(x:0.2584541062801932*self.view.frame.width, y:0.05580357142857143*self.view.frame.height, width:0.4758454106280193*self.view.frame.width,height:0.04575892857142857*self.view.frame.height)
        
        getTreeksLabel.adjustsFontSizeToFitWidth = true
        getTreeksLabel.minimumScaleFactor = 0.1
        getTreeksLabel.numberOfLines = 0
        getTreeksLabel.lineBreakMode = .byClipping
        
        transportationLabel.frame = CGRect(x:0.1956521739130435*self.view.frame.width, y:0.18973214285714285*self.view.frame.height, width:0.6111111111111112*self.view.frame.width,height:0.04575892857142857*self.view.frame.height)

        transportationLabel.adjustsFontSizeToFitWidth = true
        transportationLabel.minimumScaleFactor = 0.1
        transportationLabel.numberOfLines = 0
        transportationLabel.lineBreakMode = .byClipping
        
        firstTreekLabel.frame = CGRect(x:0.12560386473429952*self.view.frame.width, y:0.14285714285714285*self.view.frame.height, width:0.1111111111111111*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
        
        firstTreekLabel.adjustsFontSizeToFitWidth = true
        firstTreekLabel.minimumScaleFactor = 0.1
        firstTreekLabel.numberOfLines = 0
        firstTreekLabel.lineBreakMode = .byClipping
        
        secondTreekLabel.frame = CGRect(x:0.34541062801932365*self.view.frame.width, y:0.14285714285714285*self.view.frame.height, width:0.12077294685990338*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
        
        secondTreekLabel.adjustsFontSizeToFitWidth = true
        secondTreekLabel.minimumScaleFactor = 0.1
        secondTreekLabel.numberOfLines = 0
        secondTreekLabel.lineBreakMode = .byClipping
        
        thirdTreekLabel.frame = CGRect(x:0.6642512077294686*self.view.frame.width, y:0.14285714285714285*self.view.frame.height, width:0.12077294685990338*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
        
        thirdTreekLabel.adjustsFontSizeToFitWidth = true
        thirdTreekLabel.minimumScaleFactor = 0.1
        thirdTreekLabel.numberOfLines = 0
        thirdTreekLabel.lineBreakMode = .byClipping
        
        progressPerPercent =  Double(thirdWhiteProgressViewXpos + thirdWhiteProgressViewXpos - firstWhiteProgressViewXPos)/100
    }
    
    func setAllArrays(){
        routeLength = (saveDef.array(forKey: "allRoutesLengthArray") ?? [[],[],[],[],[]]) as! Array<Array<Any>>
        foodForMeals = (saveDef.array(forKey: "foodForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        weightForMeals = (saveDef.array(forKey: "wieghtForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        allDrinks = saveDef.stringArray(forKey: "allDrinks") ?? []
        allDrinksVolume = (saveDef.array(forKey: "allDrinksVolumeArray") ?? []) as! Array<Float>
    }
    
    func setBoolsForTreeks(){
        firstTreekAchieved = saveDef.bool(forKey: "firstTreek")
        secondTreekAchieved = saveDef.bool(forKey: "secondTreek")
        thirdTreekAchieved = saveDef.bool(forKey: "thirdTreek")
    }
    
    func getTipsSettled(){
        let tipsAr = tipsClass.arrangeTipsAndImages(foodTipsAvailable: true,  drinksTipsAvailable: saveDef.bool(forKey: "isDrinkTipAvailable"), transportTipsAvailable: saveDef.bool(forKey: "isTransportTipAvailable"))
        
        Tips = tipsAr[0]
        TipsCheckMark = [Bool](repeating: false, count: tipsAr[0].count)
        TipsImages = tipsAr[1]
        
    }
    
    func settleTipsIfSaved(){
        Tips = saveDef.stringArray(forKey: "tipsArray") ?? []
        TipsImages = saveDef.stringArray(forKey: "tipsImagesArray") ?? []
        TipsCheckMark = (saveDef.array(forKey: "tipsCheckMarkArray") ?? []) as! Array<Bool>
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        
        savedDate = saveDef.string(forKey: "dateToCheck") ?? ""
        
        treeks = saveDef.integer(forKey: "treeks")
    
        if dateClassRef.compareDate(date: savedDate) == false{
                newDay()
        }
        setAllArrays()
        
        settleTipsIfSaved()
        
        setArraysForTransport()
        setBoolsForTreeks()
        setToTheBegining()
        let percentage = treeksClass.getTreeksPercentage()*100
    
        progressBar(percentage:percentage)
        currentPage = "transport"
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(perfomToMap), userInfo: nil, repeats: true)
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
    
    func setToTheBegining(){
        zeroToTTPercentView.isHidden = false
        ttToFiftuPercentView.isHidden = false
        toHudreedPercentView.isHidden = false
        zeroToTTPercentImage.isHidden = false
        ttTofiftyPercentImahe.isHidden = false
        toHundreedPercentImage.isHidden = false
        zeroToTTPercentImage.image = nil
        toHundreedPercentImage.image = nil
        zeroToTTPercentImage.image = nil
        firsSeparator.isHidden = false
        secondSeparator.isHidden = false
        
        zeroToTTPercentView.frame = CGRect(x:0.07729468599033816*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.21739130434782608*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        ttToFiftuPercentView.frame = CGRect(x:0.2946859903381642*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.21739130434782608*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        toHudreedPercentView.frame = CGRect(x:0.5120772946859904*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.4106280193236715*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        
        zeroToTTPercentImage.frame = CGRect(x:0.07729468599033816*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.20531400966183574*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        ttTofiftyPercentImahe.frame = CGRect(x:0.2946859903381642*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.21739130434782608*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        toHundreedPercentImage.frame = CGRect(x:0.5241545893719807*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.39855072463768115*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        
        firsSeparator.frame = CGRect(x:0.2826086956521739*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.012077294685990338*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
        secondSeparator.frame = CGRect(x:0.5120772946859904*self.view.frame.width, y:0.1171875*self.view.frame.height, width:0.012077294685990338*self.view.frame.width,height:0.016741071428571428*self.view.frame.height)
    }
    
    func progressBar(percentage:Double){
        if percentage > 0 {
            if percentage < 20{
                
                let xPos = zeroToTTPercentImage.frame.origin.x
                let yPos = zeroToTTPercentImage.frame.origin.y
                let width = zeroToTTPercentImage.frame.width
//                progressPerPercent = width / 100
                zeroToTTPercentView.frame = CGRect(x: xPos+CGFloat(progressPerPercent*percentage+5), y: yPos, width: width-CGFloat(progressPerPercent*percentage), height: self.zeroToTTPercentView.frame.height)
            }
            else if percentage>=20 && percentage<24{
                let width = zeroToTTPercentImage.frame.width
                
    //            progressPerPercent = width / 100
                let xPos = zeroToTTPercentView.frame.origin.x
                let yPos = zeroToTTPercentView.frame.origin.y
               
                zeroToTTPercentView.frame = CGRect(x: xPos+CGFloat(progressPerPercent*percentage+5), y: yPos, width: width-CGFloat(progressPerPercent*percentage), height: self.zeroToTTPercentView.frame.height)
            }
            else if percentage>=24 && percentage<47{
                if firstTreekAchieved == false{
                    treeks+=1
                    firstTreekAchieved = true
                    saveDef.set(treeks, forKey: "treeks")
                    saveDef.set(firstTreekAchieved, forKey: "firstTreek")
                    saveDef.synchronize()
                }    //            var widthOf = zeroToTTPercentImage.frame.width
                
    //            progressPerPercent = width / 100
                
                let widthOfThisBar = ttTofiftyPercentImahe.frame.width
                
                firsSeparator.isHidden = true
                zeroToTTPercentView.isHidden = true
                zeroToTTPercentImage.image = UIImage(named: "pbFrD")
                zeroToTTPercentImage.layer.cornerRadius = 0
                zeroToTTPercentImage.backgroundColor = nil
                
                let xPos = ttTofiftyPercentImahe.frame.origin.x
                let yPos = ttTofiftyPercentImahe.frame.origin.y
                
                ttToFiftuPercentView.frame = CGRect(x: xPos+CGFloat(progressPerPercent*(percentage-24)+5), y: yPos, width: widthOfThisBar-CGFloat(progressPerPercent*(percentage-24)), height: self.ttToFiftuPercentView.frame.height)
                
            }
            else if percentage>=47 && percentage<50{
                
                let widthOfThisBar = ttTofiftyPercentImahe.frame.width
                
                firsSeparator.isHidden = true
                zeroToTTPercentView.isHidden = true
                zeroToTTPercentImage.image = UIImage(named: "pbFrD")
                zeroToTTPercentImage.layer.cornerRadius = 0
                zeroToTTPercentImage.backgroundColor = nil
                
                let xPos = ttTofiftyPercentImahe.frame.origin.x
                let yPos = ttTofiftyPercentImahe.frame.origin.y
                
                ttToFiftuPercentView.frame = CGRect(x: xPos+CGFloat(progressPerPercent*(percentage-24)+5), y: yPos, width: widthOfThisBar-CGFloat(progressPerPercent*(percentage-24)), height: self.ttToFiftuPercentView.frame.height)
            }
            else if percentage>=50 && percentage<90{
                if firstTreekAchieved == false{
                    treeks+=1
                    firstTreekAchieved = true
                    saveDef.set(treeks, forKey: "treeks")
                    saveDef.set(firstTreekAchieved, forKey: "firstTreek")
                    saveDef.synchronize()
                }
                if secondTreekAchieved == false{
                    treeks+=1
                    secondTreekAchieved = true
                    saveDef.set(treeks, forKey: "treeks")
                    saveDef.set(secondTreekAchieved, forKey: "secondTreek")
                    saveDef.synchronize()
                }
                let width = toHundreedPercentImage.frame.width
                
                firsSeparator.isHidden = true
                zeroToTTPercentView.isHidden = true
                zeroToTTPercentImage.image = UIImage(named: "pbFrD")
                zeroToTTPercentImage.layer.cornerRadius = 0
                zeroToTTPercentImage.backgroundColor = nil
                
                secondSeparator.isHidden = true
                ttToFiftuPercentView.isHidden = true
                ttTofiftyPercentImahe.image = UIImage(named: "pdSecD")
                ttTofiftyPercentImahe.backgroundColor = nil
                
                let xPos = toHundreedPercentImage.frame.origin.x
                let yPos = toHundreedPercentImage.frame.origin.y
                
                toHudreedPercentView.frame = CGRect(x: xPos+CGFloat(progressPerPercent*(percentage-50)), y: yPos, width: width-CGFloat(progressPerPercent*(percentage-50)), height: self.ttToFiftuPercentView.frame.height)
                
            }
            else if percentage>=90 && percentage<100{
            
                let width = toHundreedPercentImage.frame.width
                
                firsSeparator.isHidden = true
                zeroToTTPercentView.isHidden = true
                zeroToTTPercentImage.image = UIImage(named: "pbFrD")
                zeroToTTPercentImage.layer.cornerRadius = 0
                zeroToTTPercentImage.backgroundColor = nil
                
                secondSeparator.isHidden = true
                ttToFiftuPercentView.isHidden = true
                ttTofiftyPercentImahe.image = UIImage(named: "pdSecD")
                ttTofiftyPercentImahe.backgroundColor = nil
                
                let xPos = toHundreedPercentImage.frame.origin.x
                let yPos = toHundreedPercentImage.frame.origin.y
                
                toHudreedPercentView.frame = CGRect(x: xPos+CGFloat(progressPerPercent*(percentage-50)+5), y: yPos, width: width-CGFloat(progressPerPercent*(percentage-50)-5), height: self.ttToFiftuPercentView.frame.height)
            }
            else{
                if firstTreekAchieved == false{
                    treeks+=1
                    firstTreekAchieved = true
                    saveDef.set(treeks, forKey: "treeks")
                    saveDef.set(firstTreekAchieved, forKey: "firstTreek")
                    saveDef.synchronize()
                }
                if secondTreekAchieved == false{
                    treeks+=1
                    secondTreekAchieved = true
                    saveDef.set(treeks, forKey: "treeks")
                    saveDef.set(secondTreekAchieved, forKey: "secondTreek")
                    saveDef.synchronize()
                }
                if thirdTreekAchieved == false{
                    treeks+=1
                    thirdTreekAchieved = true
                    saveDef.set(treeks, forKey: "treeks")
                    saveDef.set(secondTreekAchieved, forKey: "thirdTreek")
                    saveDef.synchronize()
                }
                firsSeparator.isHidden = true
                zeroToTTPercentView.isHidden = true
                zeroToTTPercentImage.image = UIImage(named: "pbFrD")
                zeroToTTPercentImage.layer.cornerRadius = 0
                zeroToTTPercentImage.backgroundColor = nil
                
                secondSeparator.isHidden = true
                ttToFiftuPercentView.isHidden = true
                ttTofiftyPercentImahe.image = UIImage(named: "pdSecD")
                ttTofiftyPercentImahe.backgroundColor = nil
                
                toHudreedPercentView.isHidden = true
                toHundreedPercentImage.backgroundColor = nil
                toHundreedPercentImage.layer.cornerRadius = 0
                toHundreedPercentImage.image = UIImage(named: "pbThirdD")
            }
            let userId = Auth.auth().currentUser!.uid
            
            let referenceToAllUsers = db.collection("ids").document("userIds")
            referenceToAllUsers.getDocument { (document, error) in
                if let document = document {
                    let data = document.data()
                        self.db.collection("usersInfo").document("\(userId)").setData([
                            "treeksAmount":saveDef.integer(forKey: "treeks"),
                            "housingManAmount":saveDef.integer(forKey: "housingMan"),
                            "drinksManAmount":saveDef.integer(forKey: "drinksMan"),
                            "transportingManAmount":saveDef.integer(forKey: "transportMan"),
                            "drinksMan":saveDef.integer(forKey: "isDrinkTipAvailable"),
                            "transportMan":saveDef.integer(forKey: "isTransportTipAvailable")
                        ])
                    }
                else {
                  print("Document does not exist in cache")
                }
              }
        }
    }
    
    @objc func perfomToMap(){
        
        

        
        if shouldSegueToMApBePerformed{
            timer.invalidate()
            performSegue(withIdentifier: "goToMap", sender: self)
            shouldSegueToMApBePerformed = false
        }
        
    }
}
