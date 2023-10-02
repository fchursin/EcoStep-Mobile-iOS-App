//
//  tableViewControllerForTips.swift
//  EcoStep1
//
//  Created by Федор on 15.02.2022.
//

import UIKit
import GoogleMobileAds

var Tips:Array<String> = []
var TipsCheckMark:Array<Bool> = []
var TipsImages:Array<String> = []

var tipsLimited = true

class tableVCForTips:UITableViewController, GADFullScreenContentDelegate{
//    @IBOutlet var tableView: UITableView!
    
   var tipsCounter = 0
    
    var adPos = 0
    
    func settleTipsIfSaved(){
        Tips = saveDef.stringArray(forKey: "tipsArray") ?? []
        TipsImages = saveDef.stringArray(forKey: "tipsImagesArray") ?? []
        TipsCheckMark = (saveDef.array(forKey: "tipsCheckMarkArray") ?? []) as! Array<Bool>
    }
   
  
    //"Yous should eat less meat","You should drink more","You should lose some weight"
    
    private var rewardedAd: GADRewardedAd?
    
    func loadRewardedAd() {
       let request = GADRequest()
       GADRewardedAd.load(withAdUnitID:"ca-app-pub-2619768502886795/7268697888",
                          request: request,
                          completionHandler: { [self] ad, error in
         if let error = error {
           print("Failed to load rewarded ad with error: \(error.localizedDescription)")
           return
         }
         rewardedAd = ad
         print("Rewarded ad loaded.")
       }
       )
     }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        loadRewardedAd()
        tipsLimited = saveDef.bool(forKey: "timpsLimitedBool")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.reloadData()
        
        tipsCounter = Tips.count
        if tipsCounter<3{
            adPos = tipsCounter
        }
        else{
            adPos = 3
        }
       
        
    }
    
    func show() {
      if let ad = rewardedAd {
        ad.present(fromRootViewController: self) {
          let reward = ad.adReward
        
            tipsLimited = false
            saveDef.set(tipsLimited, forKey: "timpsLimitedBool")
            saveDef.synchronize()
            if Tips.count > 3{
                for i in 0..<TipsCheckMark.count{
                    if TipsCheckMark[i]{
                        if Tips.count > 3{
                            TipsCheckMark.remove(at: i)
                            Tips.remove(at: i)
                            TipsImages.remove(at: i)
                          
                            self.tipsCounter = Tips.count
                          if self.tipsCounter<3{
                              self.adPos = self.tipsCounter
                          }
                      else{
                          self.adPos = 3
                      }
                      self.tableView.reloadData()
                  }
                  break
              }
          }
      }
          
          // TODO: Reward the user.
        }
      } else {
        print("Ad wasn't ready")
      }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height*0.14038
        
    }

    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        if Tips.isEmpty {
            
            shouldEcoStepiBeShown = true
            
            let label = UILabel()
         
            label.text = "Tips for reducing your footprint will be displayed here"
            label.frame = CGRect(x: self.view.frame.midX-(self.view.frame.width*0.932944/2), y: 0, width: self.view.frame.width*0.932944, height: self.view.frame.height*0.14038)
            label.numberOfLines = 2
     
            label.textAlignment = .center
            view.addSubview(label)
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        
        else{
            
            shouldEcoStepiBeShown = false
            
            let label = UILabel()
            label.text = "Tips for reducing your footprint:"
            label.frame = CGRect(x: self.view.frame.midX-(self.view.frame.width*0.932944/2), y: 0, width: self.view.frame.width*0.932944, height: self.view.frame.height*0.14038)
            label.textAlignment = .center
 
            view.addSubview(label)
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        return view
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height*0.16198
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Tips.isEmpty{
            return 0
        }
        else if Tips.count >= 3 {
            return 4
        }
        else{
            return Tips.count + 1
        }
    }
//    lastCellWithOutLimit
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == adPos{
            if tipsLimited{
                let cell = tableView.dequeueReusableCell(withIdentifier: "lastCell",for: indexPath)
                cell.clearsContextBeforeDrawing = true
                cell.backgroundColor = .white
                
                let view = UIView()
                view.backgroundColor = .white
                view.frame = CGRect(x: self.view.frame.width*0.01457, y: self.view.frame.height*0.0107, width: cell.frame.width-(self.view.frame.width*0.02915), height: self.view.frame.height*0.14038)
                
                let image = UIImageView()
                image.contentMode = .scaleAspectFit
                image.image = UIImage(systemName: "play")
                image.frame = CGRect(x: self.view.frame.width*0.014577, y: self.view.frame.height*0.03239, width: self.view.frame.width*0.10204, height: self.view.frame.height*0.075593)
                image.tintColor = UIColor(red: 0.396, green: 0.769, blue: 0.4, alpha: 1)
                
                
                    view.addSubview(image)
             
                let label = UILabel()
                label.numberOfLines = 2
                
                label.text = "You have only 3 free tips. Watch add to get more!"
            
                
                label.textAlignment = .left
                label.frame = CGRect(x: cell.frame.width*0.1457725, y: 0, width: cell.frame.width * 0.75, height:cell.frame.height*0.866704)
                label.adjustsFontSizeToFitWidth = true
                view.addSubview(label)
                cell.addSubview(view)
                
                cell.layer.cornerRadius = 20
                cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                
                return cell
                
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "lastCellWithOutLimit",for: indexPath)
                
                cell.clearsContextBeforeDrawing = true
                cell.backgroundColor = .white
                
                let view = UIView()
                view.backgroundColor = .white
                view.frame = CGRect(x: self.view.frame.width*0.01457, y: self.view.frame.height*0.0107, width: cell.frame.width-(self.view.frame.width*0.02915), height: self.view.frame.height*0.14038)
                
             
                let label = UILabel()
                label.numberOfLines = 2
                label.adjustsFontSizeToFitWidth = true
                let tipsLeft = Tips.count - 3
                if tipsLeft <= 0 {
                    label.text = "You have no more tips!"
                }
                else{
                label.text = "You have \(tipsLeft) tips more!"
                }
                
                label.textAlignment = .left
                label.frame = CGRect(x: cell.frame.width*0.1457725, y: 0, width: cell.frame.width * 0.75, height:cell.frame.height*0.866704)
                
                view.addSubview(label)
                cell.addSubview(view)
                
                cell.layer.cornerRadius = 20
                cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                
                return cell
                
            }
           
        }
        else{
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.image = UIImage(named: TipsImages[indexPath.row])
           
            
//            switch TipsImages[indexPath.row]{
//            case "cookieMan":
//                widthOfImage = heightOfImage
//                cell = tableView.dequeueReusableCell(withIdentifier: "cellForTransportTip", for: indexPath)
//            case "ecohouse":
//                widthOfImage = heightOfImage / 1.04
//                cell = tableView.dequeueReusableCell(withIdentifier: "cellForHousingTip", for: indexPath)
//            case "ecocup":
//                widthOfImage = heightOfImage / 1.61
//                x = 15
//                cell = tableView.dequeueReusableCell(withIdentifier: "cellForDrinkTip", for: indexPath)
//            default:
//                print("Error")
//            }
            
            
            if TipsCheckMark[indexPath.row]{
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
            
            let view = UIView()
            view.backgroundColor = .clear
            view.frame = CGRect(x: self.view.frame.width*0.01457, y: self.view.frame.height*0.0107, width: cell.frame.width-(self.view.frame.width*0.02915), height: self.view.frame.height*0.14038)
//            view.backgroundColor = .blue
            
            
            
            image.frame = CGRect(x: cell.frame.width*0.015625, y: 0, width: cell.frame.width*0.171875, height: view.frame.height)
            
         
            
            let label = UILabel()
            label.text = String(Tips[indexPath.row].dropFirst(4))
            label.numberOfLines = 4
            label.adjustsFontSizeToFitWidth = true
//            label.backgroundColor = .blue
            label.frame = CGRect(x:cell.frame.width*0.21875 , y: 0, width: cell.frame.width-100, height:view.frame.height)
            
            
            view.addSubview(image)
            view.addSubview(label)
            
            
            
            cell.addSubview(view)
            return cell
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < TipsCheckMark.count{
            if TipsCheckMark[indexPath.row]{
                TipsCheckMark[indexPath.row] = false
            }
            else{
                TipsCheckMark[indexPath.row] = true
                Timer.scheduledTimer(timeInterval: 2, target: self, selector:#selector(deleteTipAtRow(sender:)), userInfo: indexPath.row, repeats: false)
            }
        }
        else if indexPath.row == Tips.count{
            if tipsLimited{
                show()
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
      
        tableView.reloadData()
        
    }
    
    @objc func deleteTipAtRow(sender: Timer){
        
        if tipsLimited{
            show()
        }
        else{
            if Tips.count > 3{
                let tipPos = sender.userInfo
                
                TipsCheckMark.remove(at: tipPos as! Int)
                Tips.remove(at: tipPos as! Int)
                TipsImages.remove(at: tipPos as! Int)
                tipsCounter = Tips.count
             
                if tipsCounter<3{
                    adPos = tipsCounter
                }
                else{
                    adPos = 3
                }
                tableView.reloadData()
            }
        }
    }
}
