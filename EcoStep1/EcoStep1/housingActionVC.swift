//
//  housingActionVC.swift
//  EcoStep1
//
//  Created by Федор on 30.12.2021.
//

import UIKit

class housingActionVC: UIViewController{
    @IBOutlet weak var zeroToTTPercentImage: UIImageView!
    @IBOutlet weak var ttTofiftyPercentImahe: UIImageView!
    @IBOutlet weak var toHundreedPercentImage: UIImageView!
    
    @IBOutlet weak var zeroToTTPercentView: UIView!
    @IBOutlet weak var ttToFiftuPercentView: UIView!
    @IBOutlet weak var toHudreedPercentView: UIView!
    
    @IBOutlet weak var firsSeparator: UIView!
    @IBOutlet weak var secondSeparator: UIView!
    
    
    
    var progressPerPercent = 3.5
    var percentage = 45.0
    
    override func viewWillAppear(_ animated: Bool) {
        progressBar()
    }
    
    func progressBar(){
        if percentage < 20{
            
            let xPos = zeroToTTPercentImage.frame.origin.x
            let yPos = zeroToTTPercentImage.frame.origin.y
            let width = zeroToTTPercentImage.frame.width
            progressPerPercent = width / 100
            zeroToTTPercentView.frame = CGRect(x: xPos+CGFloat(progressPerPercent*percentage+5), y: yPos, width: width-CGFloat(progressPerPercent*percentage), height: self.zeroToTTPercentView.frame.height)
        }
        else if percentage>=20 && percentage<24{
            let width = zeroToTTPercentImage.frame.width
            
            percentage = 20
//            progressPerPercent = width / 100
            let xPos = zeroToTTPercentView.frame.origin.x
            let yPos = zeroToTTPercentView.frame.origin.y
           
            zeroToTTPercentView.frame = CGRect(x: xPos+CGFloat(progressPerPercent*percentage+5), y: yPos, width: width-CGFloat(progressPerPercent*percentage), height: self.zeroToTTPercentView.frame.height)
        }
        else if percentage>=24 && percentage<47{
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
            percentage = 47
            
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
            percentage = 90
            
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
    }
}


