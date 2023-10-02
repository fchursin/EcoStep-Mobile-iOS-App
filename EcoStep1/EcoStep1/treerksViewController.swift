//
//  treerksViewController.swift
//  EcoStep1
//
//  Created by Федор on 24.03.2022.
//

import UIKit
import GoogleMobileAds
import Firebase

var curretnChoosenChestToOpen = ""

var foodmanGet = 0
var drinkManGet = 0
var transportManGet = 0
var housingManGet = 0

class treeksViewController:UIViewController,UITabBarDelegate, GADFullScreenContentDelegate{
    
    var currentChoosenChest = ""
    
    var isAdAvailable = true
    
    var addFailedToLoad = false
    
    var addRewareded = false
    
    let db = Firestore.firestore()
    
    let tipsClass = arrangeTipsAndImages()

    
    let dateClassRef = dateClass()
    
    @IBOutlet weak var whiteBoard: UIImageView!
    @IBOutlet weak var smallChest: UIButton!
    @IBOutlet weak var mediumChest: UIButton!
    @IBOutlet weak var bigChest: UIButton!
    @IBOutlet weak var treeksLine: UIProgressView!
    
    @IBOutlet weak var chestImage: UIImageView!
    @IBOutlet weak var chestNameLabel: UILabel!
    @IBOutlet weak var chestPrice: UILabel!
    @IBOutlet weak var cardsInChest: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var openBtn: UIButton!
    
    @IBOutlet weak var boxesLabel: UILabel!
    @IBOutlet weak var ecoTeamLabel: UILabel!
    @IBOutlet weak var treeksAmountAvailable: UILabel!
    
    var timerForSegue = Timer()
    var timerForAdd = Timer()
    
    func layoutAllViews(){
        whiteBoard.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.39285714285714285*self.view.frame.height)
        smallChest.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.44419642857142855*self.view.frame.height, width:0.24154589371980675*self.view.frame.width,height:0.11160714285714286*self.view.frame.height)
        mediumChest.frame = CGRect(x:0.37922705314009664*self.view.frame.width, y:0.44419642857142855*self.view.frame.height, width:0.24154589371980675*self.view.frame.width,height:0.11160714285714286*self.view.frame.height)
        bigChest.frame = CGRect(x:0.6908212560386473*self.view.frame.width, y:0.44419642857142855*self.view.frame.height, width:0.24154589371980675*self.view.frame.width,height:0.11160714285714286*self.view.frame.height)
        treeksLine.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.08816964285714286*self.view.frame.height, width:0.9033816425120773*self.view.frame.width,height:0.004464285714285714*self.view.frame.height)
        chestImage.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.1015625*self.view.frame.height, width:0.30193236714975846*self.view.frame.width,height:0.13950892857142858*self.view.frame.height)
        chestNameLabel.frame = CGRect(x:0.4758454106280193*self.view.frame.width, y:0.1015625*self.view.frame.height, width:0.45652173913043476*self.view.frame.width,height:0.052455357142857144*self.view.frame.height)
        chestPrice.frame = CGRect(x:0.4758454106280193*self.view.frame.width, y:0.14508928571428573*self.view.frame.height, width:0.3864734299516908*self.view.frame.width,height:0.052455357142857144*self.view.frame.height)
        cardsInChest.frame = CGRect(x:0.4758454106280193*self.view.frame.width, y:0.18861607142857142*self.view.frame.height, width:0.4057971014492754*self.view.frame.width,height:0.052455357142857144*self.view.frame.height)
        openBtn.frame = CGRect(x:0.2946859903381642*self.view.frame.width, y:0.2700892857142857*self.view.frame.height, width:0.4106280193236715*self.view.frame.width,height:0.0546875*self.view.frame.height)
        treeksAmountAvailable.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.049107142857142856*self.view.frame.height, width:0.9033816425120773*self.view.frame.width,height:0.04352678571428571*self.view.frame.height)
        containerView.frame = CGRect(x:0.0*self.view.frame.width, y:0.6372767857142857*self.view.frame.height, width:1.0*self.view.frame.width,height:0.234375*self.view.frame.height)
        boxesLabel.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.38058035714285715*self.view.frame.height, width:0.9033816425120773*self.view.frame.width,height:0.04352678571428571*self.view.frame.height)
        ecoTeamLabel.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.5848214285714286*self.view.frame.height, width:0.9033816425120773*self.view.frame.width,height:0.04352678571428571*self.view.frame.height)
        
        treeksAmountAvailable.adjustsFontSizeToFitWidth = true
        cardsInChest.adjustsFontSizeToFitWidth = true
        chestPrice.adjustsFontSizeToFitWidth = true
        chestNameLabel.adjustsFontSizeToFitWidth = true
        ecoTeamLabel.adjustsFontSizeToFitWidth = true
        boxesLabel.adjustsFontSizeToFitWidth = true
        openBtn.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    private var rewardedAd: GADRewardedAd?

    
    var savedDate = ""
    
//    override func viewDidAppear(_ animated: Bool) {
//        if saveDef.bool(forKey: "treeksFirstLaunch") == false{
//            performSegueToCasePage()
//        }
//    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        
        if saveDef.bool(forKey: "boxOpenAfterAd") == true{
            curretnChoosenChestToOpen = saveDef.string(forKey: "boxToOpenAfterAd")!
            performSegueToCasePage()
            saveDef.set(false, forKey: "boxOpenAfterAd")
        }
        
        loadRewardedAd()
        
        onBoardPage = "treeks"
        
        layoutAllViews()
      
        savedDate = saveDef.string(forKey: "dateToCheck") ?? ""
        
        treeks = saveDef.integer(forKey: "treeks")
    
        if dateClassRef.compareDate(date: savedDate) == false{
                newDay()
        }
        setAllArrays()
        
        settleTipsIfSaved()
        
        
        isAdAvailable = saveDef.bool(forKey: "isAdAvailable")
        
        treeks = saveDef.integer(forKey: "treeks")
        
        currentChoosenChest = "small"
    
        treeksAmountAvailable.text = "Treeks available : \(treeks)"
        
        openBtn.layer.cornerRadius = 10
        openBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        setChestImageAndChestButton(chest:currentChoosenChest)
        
      
    }
    
    func settleTipsIfSaved(){
        Tips = saveDef.stringArray(forKey: "tipsArray") ?? []
        TipsImages = saveDef.stringArray(forKey: "tipsImagesArray") ?? []
        TipsCheckMark = (saveDef.array(forKey: "tipsCheckMarkArray") ?? []) as! Array<Bool>
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
    
    func addNewCards(){
        if droppedCards.isEmpty == false{
            for i in 0..<droppedCards.count{
                switch droppedCards[i]{
                case "carCard":
                    transportManGet += 1
                case "ecoCupCard":
                    drinkManGet += 1
                case "questionMarkCard":
                    housingManGet += 1
                default:
                    print("error2")
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if addRewareded == true{
            timerForAdd.invalidate()
            timerForSegue.invalidate()
            addRewareded = false
        }
    }
    
    //ca-app-pub-2619768502886795/2538817983
    
    func loadRewardedAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID:"ca-app-pub-2619768502886795/1024752220",
                           request: request,
                           completionHandler: { [self] ad, error in
          if let error = error {
            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
              addFailedToLoad = true
            return
          }
          rewardedAd = ad
          print("Rewarded ad loaded.")
        }
        )
        rewardedAd?.fullScreenContentDelegate = self
      }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        loadRewardedAd()
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad will present full screen content.
      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
          loadRewardedAd()
        print("Ad did dismiss full screen content.")
      }
    
    
    
    @objc func performSegueToCasePage(){
        
            performSegue(withIdentifier: "goToChestOpenPage", sender: treeksViewController())
        
    }
    
    
    func show() {
      if let ad = rewardedAd {
        ad.present(fromRootViewController: self) {
          let reward = ad.adReward
          print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
            saveDef.set(false, forKey: "isAdAvailable")
            saveDef.set(true, forKey: "boxOpenAfterAd")
            saveDef.set(self.currentChoosenChest, forKey: "boxToOpenAfterAd")
            saveDef.synchronize()
            self.timerForAdd.invalidate()
            self.addRewareded = true
            self.performSegueToCasePage()
        }
      } else {
          openBtn.setTitle("Ad wasn't ready try one more time", for: .normal)
        print("Ad wasn't ready")
      }
    }

    @IBAction func openBtnPressed(_ sender: UIButton) {
        
        var amountOfTreeksNeeded = 0
        if currentChoosenChest == "small"{
            amountOfTreeksNeeded = 3
            curretnChoosenChestToOpen = "small"
        }
        else if currentChoosenChest == "medium"{
            amountOfTreeksNeeded = 5
            curretnChoosenChestToOpen = "medium"
        }
        else if currentChoosenChest == "big"{
            amountOfTreeksNeeded = 9
            curretnChoosenChestToOpen = "big"
        }
        else{
            print("error")
        }
        if treeks < amountOfTreeksNeeded && isAdAvailable && addFailedToLoad == false{
            show()
         
        }
        else if treeks < amountOfTreeksNeeded && isAdAvailable && addFailedToLoad{
            openBtn.setTitle("Ad is not available now!", for: .normal)
        }
        else if treeks>=amountOfTreeksNeeded{
            treeks -= amountOfTreeksNeeded
            saveDef.set(treeks, forKey: "treeks")
            saveDef.synchronize()
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
            performSegue(withIdentifier: "goToChestOpenPage", sender: self)
        }
    }
    
    @objc func layoutSubs(){
        self.updateViewConstraints()
    }
    
    func setChestImageAndChestButton(chest:String){
        switch chest{
        case "small":
            currentChoosenChest = "small"
            chestImage.image = UIImage(named: "smallChestClosed1")
            chestNameLabel.text = "Small Box:"
            chestPrice.text = "Price: 3 Treeks"
            cardsInChest.text = "3 Random Cards"
            
            smallChest.layer.cornerRadius = 20
            smallChest.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            smallChest.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
            
            mediumChest.backgroundColor = .clear
            bigChest.backgroundColor = .clear
            
            if treeks<3 && isAdAvailable && addFailedToLoad == false{
                openBtn.setTitle("Watch Ad To Open!", for: .normal)
            }
            else if treeks<3 && isAdAvailable == true && addFailedToLoad == true{
                openBtn.setTitle("Ad is not available now!", for: .normal)
            }
            else if treeks<3 && isAdAvailable == false{
                openBtn.setTitle("Not enough Treeks", for: .normal)
            }
            else{
                openBtn.setTitle("Open!", for: .normal)
            }
            
        case "medium":
            currentChoosenChest = "medium"
            chestImage.image = UIImage(named: "mediumChestClosed2")
            chestNameLabel.text = "Medium Box:"
            chestPrice.text = "Price: 5 Treeks"
            cardsInChest.text = "5 Random Cards"
            
            mediumChest.layer.cornerRadius = 20
            mediumChest.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            mediumChest.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
            
            smallChest.backgroundColor = .clear
            bigChest.backgroundColor = .clear
            if treeks<5 && isAdAvailable == true && addFailedToLoad == false{
                openBtn.setTitle("Watch Ad To Open!", for: .normal)
            }
            else if treeks<5 && isAdAvailable == true && addFailedToLoad == true{
                openBtn.setTitle("Ad is not available now!", for: .normal)
            }
            else if treeks<5 && isAdAvailable == false{
                openBtn.setTitle("Not enough Treeks", for: .normal)
            }
            else{
                openBtn.setTitle("Open!", for: .normal)
            }
        case "big":
            currentChoosenChest = "big"
            chestImage.image = UIImage(named: "bigChestClosed3")
            chestNameLabel.text = "Big Box:"
            chestPrice.text = "Price: 9 Treeks"
            cardsInChest.text = "9 Random Cards"
            
            bigChest.layer.cornerRadius = 20
            bigChest.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            bigChest.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
            
            smallChest.backgroundColor = .clear
            mediumChest.backgroundColor = .clear
            
            if treeks<9 && isAdAvailable == true && addFailedToLoad == false{
                openBtn.setTitle("Watch Ad To Open!", for: .normal)
            }
            else if treeks<9 && isAdAvailable == true && addFailedToLoad == true{
                openBtn.setTitle("Ad is not available now!", for: .normal)
            }
            else if treeks<9 && isAdAvailable == false{
                openBtn.setTitle("Not enough Treeks", for: .normal)
            }
            else{
                openBtn.setTitle("Open!", for: .normal)
            }
            
        default:
            print("error")
        }
    }
    
 
    
    @IBAction func smallChestChoosen(_ sender: UIButton) {
        setChestImageAndChestButton(chest: "small")
    }
    
    @IBAction func mediumChestChoosen(_ sender: UIButton) {
        setChestImageAndChestButton(chest: "medium")
    }
    
    @IBAction func bigChestChoosen(_ sender: UIButton) {
        setChestImageAndChestButton(chest: "big")
    }
    
    
}


var foodImage = ""
var drinksImage = ""
var transportImage = ""
var housingImage = "questionmark"

class treeksManTableView: UITableViewController{
    
    let db = Firestore.firestore()
    
    var viewModels:[CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(
            viewModels:[
                TileCollectionViewCellViewModel(name: "Food\n Man \(foodmanGet)/1", type:"food",widthMultiplier: 0.95, description: "By unlocking this guy you will be able to get food tips!" ),
                TileCollectionViewCellViewModel(name: "Drink\n Man \(drinkManGet)/10",type:"drinks",widthMultiplier: 0.62,description: "By unlocking this guy you will be able to get tips about drinks!"),
                TileCollectionViewCellViewModel(name: "Transport\n Man \(transportManGet)/15",type:"transport",widthMultiplier: 1.29,description: "By unlocking this guy you will be able to get transport tips!" ),
                TileCollectionViewCellViewModel(name: "Mystery\n Man \(housingManGet)/25", type:"housing",widthMultiplier: 0.95,description: "?")
        ])
    ]
  
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        
        foodmanGet = 1
        drinkManGet = saveDef.integer(forKey: "drinksMan")
        transportManGet = saveDef.integer(forKey: "transportMan")
        housingManGet = saveDef.integer(forKey: "housingMan")
        
        droppedCards = saveDef.stringArray(forKey: "droppedCards") ?? []

        addNewCards()
      
        foodImage = getImageForCell(imageName:"food")
        drinksImage = getImageForCell(imageName:"dirnks")
        transportImage = getImageForCell(imageName: "transport")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        tableView.separatorColor = .clear
        tableView.isScrollEnabled = false
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height
    }
    
    func getImageForCell(imageName:String)->String{
        var finalStringImage:String = ""
        
        switch imageName{
        case "food":
            if foodmanGet>=1{
                finalStringImage = "cookieMan"
            }
            else{
                finalStringImage = "cookieManNotAchieved"
            }
        case "transport":
            if transportManGet >= 15{
                finalStringImage = "ecocar"
                saveDef.setValue(true, forKey: "isTransportTipAvailable")
                saveDef.set(15, forKey: "transportMan")
                saveDef.synchronize()
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
            else{
                finalStringImage = "ecocarNotOpened"
            }
        case "dirnks":
            if drinkManGet >= 10{
                finalStringImage = "ecocup"
                saveDef.setValue(true, forKey: "isDrinkTipAvailable")
                saveDef.set(10, forKey: "drinksMan")
                saveDef.synchronize()
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
            else{
                finalStringImage = "ecocupNotAchieved"
            }
        default:
            print("error")
        }
        
        
        return finalStringImage
    }
    
    func addNewCards(){
        for i in 0..<droppedCards.count{
            switch droppedCards[i]{
            case "food":
                foodmanGet += 1
                saveDef.set(foodmanGet, forKey: "foodMan")
                saveDef.synchronize()
            case "ecoCupCard":
                drinkManGet += 1
                saveDef.set(drinkManGet, forKey: "drinksMan")
                saveDef.synchronize()
            case "carCard":
                transportManGet += 1
                saveDef.set(transportManGet, forKey: "transportMan")
                saveDef.synchronize()
            case "questionMarkCard":
                housingManGet += 1
                saveDef.set(housingManGet, forKey: "housingMan")
                saveDef.synchronize()
            default:
                print("error")
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
                            "transportingManAmount":saveDef.integer(forKey: "transportingMan"),
                            "drinksMan":saveDef.integer(forKey: "isDrinkTipAvailable"),
                            "transportMan":saveDef.integer(forKey: "isTransportTipAvailable")
                        ])
                    }
                else {
                  print("Document does not exist in cache")
                }
              }
        }
        droppedCards = []
        saveDef.set(droppedCards, forKey: "droppedCards")
        saveDef.synchronize()
    viewModels = [
        CollectionTableViewCellViewModel(
            viewModels:[
                TileCollectionViewCellViewModel(name: "Food\n Man \(foodmanGet)/1", type:"food",widthMultiplier: 0.95, description: "By unlocking this guy you will be able to get food tips!" ),
                TileCollectionViewCellViewModel(name: "Drink\n Man \(drinkManGet)/10",type:"drinks",widthMultiplier: 0.62,description: "By unlocking this guy you will be able to get tips about drinks!"),
                TileCollectionViewCellViewModel(name: "Transport\n Man \(transportManGet)/15",type:"transport",widthMultiplier: 1.29,description: "By unlocking this guy you will be able to get transport tips!" ),
                TileCollectionViewCellViewModel(name: "Mystery\n Man \(housingManGet)/25", type:"housing",widthMultiplier: 0.95,description: "?")
        ])
    ]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier,for: indexPath) as? CollectionTableViewCell else{
            fatalError()
        }
        
        cell.configure(with: viewModel)
        cell.backgroundColor = .clear
        return cell
    }
}
