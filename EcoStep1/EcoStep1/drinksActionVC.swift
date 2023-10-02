//
//  drinksActionVC.swift
//  EcoStep1
//
//  Created by Федор on 30.12.2021.
//

import UIKit
import Firebase


class drinksActionVC: UIViewController{
    let db = Firestore.firestore()
    
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
    @IBOutlet weak var drinksLabel: UILabel!
    
    @IBOutlet weak var firstTreekLabel: UILabel!
    @IBOutlet weak var secondTreekLabel: UILabel!
    @IBOutlet weak var thirdTreekLabel: UILabel!
    
    
    var progressPerPercent = 3.5
    
    
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

    let treeksClass = treeksGetClass()
    
    var savedDate = ""
    
    let dateClassRef = dateClass()
    
    let tipsClass = arrangeTipsAndImages()
    
    
    
    var timer = Timer()
    func setBoolsForTreeks(){
        firstTreekAchieved = saveDef.bool(forKey: "firstTreek")
        secondTreekAchieved = saveDef.bool(forKey: "secondTreek")
        thirdTreekAchieved = saveDef.bool(forKey: "thirdTreek")
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
        
        drinksLabel.frame = CGRect(x:0.3647342995169082*self.view.frame.width, y:0.18973214285714285*self.view.frame.height, width:0.27294685990338163*self.view.frame.width,height:0.04575892857142857*self.view.frame.height)

        drinksLabel.adjustsFontSizeToFitWidth = true
        drinksLabel.minimumScaleFactor = 0.1
        drinksLabel.numberOfLines = 0
        drinksLabel.lineBreakMode = .byClipping
        
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
    
    func setArraysForDrinks(){
        allDrinks = saveDef.stringArray(forKey: "allDrinks") ?? []
        allDrinksVolume = (saveDef.array(forKey: "allDrinksVolumeArray") ?? []) as! Array<Float>
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
        
        setArraysForDrinks()
        setBoolsForTreeks()
        setToTheBegining()
        let percentage = treeksClass.getTreeksPercentage() * 100
      
        progressBar(percentage:percentage)
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(performSegToFoodTable), userInfo: nil, repeats: true)
        currentPage = "drinks"
        
        }
    
    func setAllArrays(){
        routeLength = (saveDef.array(forKey: "allRoutesLengthArray") ?? [[],[],[],[],[]]) as! Array<Array<Any>>
        foodForMeals = (saveDef.array(forKey: "foodForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        weightForMeals = (saveDef.array(forKey: "wieghtForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        allDrinks = saveDef.stringArray(forKey: "allDrinks") ?? []
        allDrinksVolume = (saveDef.array(forKey: "allDrinksVolumeArray") ?? []) as! Array<Float>
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
    
    @objc func performSegToFoodTable(){
       
        if shoudlSegueBePerformedForDrinksTable == true{
            performSegue(withIdentifier: "goToDrinkTable", sender: self)
            shoudlSegueBePerformedForDrinksTable = false
            timer.invalidate()
        }
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
                }
    //            var widthOf = zeroToTTPercentImage.frame.width
                
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
    
    
}

class drinksVolumeViewController:UIViewController{
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cupButton: UIButton!
    @IBOutlet weak var sliderButton: UIButton!
    @IBOutlet weak var backBtnBgView: UIView!
    
    @IBAction func volumeTypeChoosen(_ sender: UIButton) {
        sliderButton.backgroundColor = UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1)
        sliderButton.setTitleColor(.white,for: .normal)
        
        cupButton.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        cupButton.setTitleColor( UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1), for: .normal)
        
        cupTypeView.isHidden = true
        volumeTypeView.isHidden = false
    }
    
    func layoutAllViews(){
        backBtn.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        backBtnBgView.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        cupButton.frame = CGRect(x:0.6014492753623188*self.view.frame.width, y:0.12723214285714285*self.view.frame.height, width:0.3502415458937198*self.view.frame.width,height:0.05580357142857143*self.view.frame.height)
        sliderButton.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.12723214285714285*self.view.frame.height, width:0.3502415458937198*self.view.frame.width,height:0.05580357142857143*self.view.frame.height)
        volumeTypeView.frame = CGRect( x:0.04830917874396135*self.view.frame.width, y:0.20089285714285715*self.view.frame.height, width:0.9033816425120773*self.view.frame.width,height:0.7611607142857143*self.view.frame.height)
        cupTypeView.frame = CGRect( x:0.04830917874396135*self.view.frame.width, y:0.20089285714285715*self.view.frame.height, width:0.9033816425120773*self.view.frame.width,height:0.7611607142857143*self.view.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
    }
    
    @IBAction func cupTypeChoosen(_ sender: UIButton) {
        sliderButton.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        sliderButton.setTitleColor( UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1), for: .normal)
        
        cupButton.backgroundColor =  UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1)
        cupButton.setTitleColor(.white, for: .normal)
        
        cupTypeView.isHidden = false
        volumeTypeView.isHidden = true
    }
    
    let prefixes = ["TE","CO","JU"]
    
    let drinksWithoutIndexesOrSpaces = ["Black Tea","Green Tea","Herbal Tea","Jasmin Tea","Americano","Cappuccino","Espresso","Black Coffee","Flat White","Latte","Mocha","Apple Juice","Orange Juice","Grapefruit Juice","Fruit Juice","Lime Juice","Pineapple Juice"]
    
    func reformDrinkStringForCalculations(choosenDrink:String)->String{
        var finalDrinkString = ""
        if prefixes.contains(String(choosenDrink.prefix(2))){
            finalDrinkString = choosenDrink
        }
        else if drinksWithoutIndexesOrSpaces.contains(choosenDrink){
            var firstIndx = drinksWithoutIndexesOrSpaces.firstIndex(of: choosenDrink)!
            if firstIndx > -1 && firstIndx<4{
                let indx = "TE"
                finalDrinkString = indx + choosenDrink
            }
            else if firstIndx>3 && firstIndx<11{
                let indx = "CO"
                finalDrinkString = indx + choosenDrink
            }
            else if firstIndx>10 && firstIndx<17{
                let indx = "JU"
                finalDrinkString = indx + choosenDrink
            }
            else{
                print("Error")
            }
        }
        else{
            var spacePos = 0
            if let i = choosenDrink.firstIndex(of: " ") {
                spacePos = choosenDrink.distance(from: choosenDrink.startIndex, to: i)
            }
            
            switch String(choosenDrink.prefix(spacePos)){
            case "Juice":
                let indx = "JU"
                finalDrinkString = indx + choosenDrink.suffix(choosenDrink.count-spacePos-1)
            case "Coffee":
                let indx = "CO"
                finalDrinkString = indx + choosenDrink.suffix(choosenDrink.count-spacePos-1)
            case "Tea":
                let indx = "TE"
                finalDrinkString = indx + choosenDrink.suffix(choosenDrink.count-spacePos-1)
            default:
               
                print("Error")
            }
        }
        return finalDrinkString
    }
    
    @IBOutlet weak var volumeTypeView: UIView!
    
    @IBOutlet weak var cupTypeView: UIView!
}

class viewControllerToSetVolumeBySlider:UIViewController{
    @IBOutlet weak var drinkSlider: UISlider!
    @IBOutlet weak var drinkSizeLabel: UILabel!
    @IBOutlet weak var setDrinkLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    func setArraysForDrinks(){
        allDrinks = saveDef.stringArray(forKey: "allDrinks") ?? []
        allDrinksVolume = (saveDef.array(forKey: "allDrinksVolumeArray") ?? []) as! Array<Float>
    }
    
    func layoutAllViews(){
        drinkSlider.frame = CGRect(x:0.12566844919786097*self.view.frame.width, y:0.47947214076246336*self.view.frame.height, width:0.7486631016042781*self.view.frame.width,height:0.04398826979472141*self.view.frame.height)
        drinkSizeLabel.frame = CGRect(x:0.2620320855614973*self.view.frame.width, y:0.4002932551319648*self.view.frame.height, width:0.4786096256684492*self.view.frame.width,height:0.05278592375366569*self.view.frame.height)
        drinkSizeLabel.adjustsFontSizeToFitWidth = true
        drinkSizeLabel.minimumScaleFactor = 0.1
        drinkSizeLabel.numberOfLines = 0
        drinkSizeLabel.lineBreakMode = .byClipping
        setDrinkLabel.frame = CGRect(x:0.17647058823529413*self.view.frame.width, y:0.06451612903225806*self.view.frame.height, width:0.660427807486631*self.view.frame.width,height:0.04985337243401759*self.view.frame.height)
        setDrinkLabel.adjustsFontSizeToFitWidth = true
        setDrinkLabel.minimumScaleFactor = 0.1
        setDrinkLabel.numberOfLines = 0
        setDrinkLabel.lineBreakMode = .byClipping
        addBtn.frame = CGRect(x:0.3663101604278075*self.view.frame.width, y:0.8020527859237536*self.view.frame.height, width:0.26737967914438504*self.view.frame.width,height:0.06598240469208211*self.view.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        setDrinkLabel.text = "Set your \(String(volumeViewControllerClass.reformDrinkStringForCalculations(choosenDrink: choosenDrink)).dropFirst(2)) size"
        allActions = saveDef.stringArray(forKey: "allActions") ?? []
        setArraysForDrinks()
        let drinksValue = String(drinkSlider.value).prefix(4)
        
        drinkSizeLabel.text = "\(drinksValue) l"
    }
    
    @IBAction func volumeDidChanged(_ sender: UISlider) {
        let drinksValue = String(drinkSlider.value).prefix(4)
        
        drinkSizeLabel.text = "\(drinksValue) l"
        
    }
    
    let volumeViewControllerClass = drinksVolumeViewController()
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let drinksVolume = Float(String(drinkSlider.value).prefix(4))
        
        allActions.append("Drink")
        
        allDrinks.append(volumeViewControllerClass.reformDrinkStringForCalculations(choosenDrink: choosenDrink))
        allDrinksVolume.append(drinksVolume ?? 0.0)
        
        saveDef.set(allActions, forKey: "allActions")
        saveDef.set(allDrinks, forKey: "allDrinks")
        saveDef.set(allDrinksVolume, forKey: "allDrinksVolumeArray")
        saveDef.synchronize()
        
        dismiss(animated: true)
    }
    
}

class viewControllerToSetVolumeByCupSize:UIViewController{
    
    func setArraysForDrinks(){
        allDrinks = saveDef.stringArray(forKey: "allDrinks") ?? []
        allDrinksVolume = (saveDef.array(forKey: "allDrinksVolumeArray") ?? []) as! Array<Float>
    }
    
    @IBOutlet weak var cupAmountStepper: UIStepper!
    @IBOutlet weak var amountOfCupsValueLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var chooseCupSizeLabel: UILabel!
    @IBOutlet weak var espressoCup: UIButton!
    @IBOutlet weak var cappuccinoCup: UIButton!
    @IBOutlet weak var latteCup: UIButton!
    @IBOutlet weak var glassCup: UIButton!
    @IBOutlet weak var teaCup: UIButton!
    @IBOutlet weak var canCup: UIButton!
    @IBOutlet weak var mugCup: UIButton!
    
    var cupVolume = 0.0
    var cupAmount = 0
    let volumeViewControllerClass = drinksVolumeViewController()
    
    func setAllCupsBtnsColourToDefault(){
        espressoCup.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        cappuccinoCup.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        latteCup.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        glassCup.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        teaCup.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        canCup.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        mugCup.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
        
    }
    
    func setCornersForAllBtns(){
        espressoCup.layer.cornerRadius = 20
        espressoCup.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cappuccinoCup.layer.cornerRadius = 20
        cappuccinoCup.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        latteCup.layer.cornerRadius = 20
        latteCup.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        glassCup.layer.cornerRadius = 20
        glassCup.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        teaCup.layer.cornerRadius = 20
        teaCup.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        canCup.layer.cornerRadius = 20
        canCup.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mugCup.layer.cornerRadius = 20
        mugCup.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
    func layoutAllViews(){
        addBtn.frame = CGRect(x:0.3663101604278075*self.view.frame.width, y:0.8020527859237536*self.view.frame.height, width:0.26737967914438504*self.view.frame.width,height:0.06598240469208211*self.view.frame.height)
        cupAmountStepper.frame = CGRect(x:0.37433155080213903*self.view.frame.width, y:0.6891495601173021*self.view.frame.height, width:0.25133689839572193*self.view.frame.width,height:0.0469208211143695*self.view.frame.height)
        amountOfCupsValueLabel.frame = CGRect(x:0.10962566844919786*self.view.frame.width, y:0.6070381231671554*self.view.frame.height, width:0.7807486631016043*self.view.frame.width,height:0.05278592375366569*self.view.frame.height)
        amountOfCupsValueLabel.adjustsFontSizeToFitWidth = true
        amountOfCupsValueLabel.minimumScaleFactor = 0.1
        amountOfCupsValueLabel.numberOfLines = 0
        amountOfCupsValueLabel.lineBreakMode = .byClipping
        chooseCupSizeLabel.frame = CGRect(x:0.13101604278074866*self.view.frame.width, y:0.10557184750733138*self.view.frame.height, width:0.7379679144385026*self.view.frame.width,height:0.05278592375366569*self.view.frame.height)
        chooseCupSizeLabel.adjustsFontSizeToFitWidth = true
        chooseCupSizeLabel.minimumScaleFactor = 0.1
        chooseCupSizeLabel.numberOfLines = 0
        chooseCupSizeLabel.lineBreakMode = .byClipping
        espressoCup.frame = CGRect(x:0.0427807486631016*self.view.frame.width, y:0.22434017595307917*self.view.frame.height, width:0.2914438502673797*self.view.frame.width,height:0.1158357771260997*self.view.frame.height)
        cappuccinoCup.frame = CGRect(x:0.35561497326203206*self.view.frame.width, y:0.22434017595307917*self.view.frame.height, width:0.2914438502673797*self.view.frame.width,height:0.1158357771260997*self.view.frame.height)
        latteCup.frame = CGRect(x:0.6657754010695187*self.view.frame.width, y:0.22434017595307917*self.view.frame.height, width:0.2914438502673797*self.view.frame.width,height:0.1158357771260997*self.view.frame.height)
        glassCup.frame = CGRect(x:0.0427807486631016*self.view.frame.width, y:0.3519061583577713*self.view.frame.height, width:0.2914438502673797*self.view.frame.width,height:0.1158357771260997*self.view.frame.height)
        teaCup.frame = CGRect(x:0.35561497326203206*self.view.frame.width, y:0.3519061583577713*self.view.frame.height, width:0.2914438502673797*self.view.frame.width,height:0.1158357771260997*self.view.frame.height)
        canCup.frame = CGRect(x:0.6657754010695187*self.view.frame.width, y:0.3519061583577713*self.view.frame.height, width:0.2914438502673797*self.view.frame.width,height:0.1158357771260997*self.view.frame.height)
        mugCup.frame = CGRect(x:0.35561497326203206*self.view.frame.width, y:0.47947214076246336*self.view.frame.height, width:0.2914438502673797*self.view.frame.width,height:0.1158357771260997*self.view.frame.height)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        setArraysForDrinks()
        setCornersForAllBtns()
    }
    
    @IBAction func espressoBtnPressed(_ sender: UIButton) {
        setAllCupsBtnsColourToDefault()
        sender.backgroundColor = .white
        cupAmountStepper.value = 1
        amountOfCupsValueLabel.text = "Amount of cups: \(Int(cupAmountStepper.value))"
        cupVolume = 0.1
        cupAmount = 1
    }
    
    @IBAction func cappucinoBtnPressed(_ sender: UIButton) {
        setAllCupsBtnsColourToDefault()
        sender.backgroundColor = .white
        cupAmountStepper.value = 1
        amountOfCupsValueLabel.text = "Amount of cups: \(Int(cupAmountStepper.value))"
        cupVolume = 0.15
        cupAmount = 1
    }
    @IBAction func latteBtnPressed(_ sender: UIButton) {
        setAllCupsBtnsColourToDefault()
        sender.backgroundColor = .white
        cupAmountStepper.value = 1
        amountOfCupsValueLabel.text = "Amount of cups: \(Int(cupAmountStepper.value))"
        cupVolume = 0.22
        cupAmount = 1
    }
    
    @IBAction func glassBtnPressed(_ sender: UIButton) {
        setAllCupsBtnsColourToDefault()
        sender.backgroundColor = .white
        cupAmountStepper.value = 1
        amountOfCupsValueLabel.text = "Amount of cups: \(Int(cupAmountStepper.value))"
        cupVolume = 0.250
        cupAmount = 1
    }
    @IBAction func teaBtnPressed(_ sender: UIButton) {
        setAllCupsBtnsColourToDefault()
        sender.backgroundColor = .white
        cupAmountStepper.value = 1
        amountOfCupsValueLabel.text = "Amount of cups: \(Int(cupAmountStepper.value))"
        cupVolume = 0.33
        cupAmount = 1
    }
    @IBAction func canBtnPressed(_ sender: UIButton) {
        setAllCupsBtnsColourToDefault()
        sender.backgroundColor = .white
        cupAmountStepper.value = 1
        amountOfCupsValueLabel.text = "Amount of cups: \(Int(cupAmountStepper.value))"
        cupVolume = 0.35
        cupAmount = 1
    }
    @IBAction func mugBtnPressed(_ sender: UIButton) {
        setAllCupsBtnsColourToDefault()
        sender.backgroundColor = .white
        cupAmountStepper.value = 1
        amountOfCupsValueLabel.text = "Amount of cups: \(Int(cupAmountStepper.value))"
        cupVolume = 0.5
        cupAmount = 1
    }
    @IBAction func changeAmountOfCups(_ sender: UIStepper) {
        amountOfCupsValueLabel.text = "Amount of cups: \(Int(sender.value))"
        cupAmount = Int(sender.value)
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        if cupAmount > 0 {
            allDrinks.append(volumeViewControllerClass.reformDrinkStringForCalculations(choosenDrink: choosenDrink))
            allDrinksVolume.append(Float(Float(cupAmount)*Float(cupVolume)))
            
            saveDef.set(allDrinks, forKey: "allDrinks")
            saveDef.set(allDrinksVolume, forKey: "allDrinksVolumeArray")
            saveDef.synchronize()
            
            allActions.append("Drink")
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
