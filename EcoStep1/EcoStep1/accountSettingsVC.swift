//
//  accountSettingsVC.swift
//  EcoStep1
//
//  Created by Федор on 01/11/2022.
//

import UIKit
import Firebase

var signOutOrDelete = ""

class accountSettingVC: UIViewController{
    
    @IBOutlet weak var deleteAccountBtn: UIButton!
    
    @IBOutlet weak var logOutBtn: UIButton!
    
    func setViewPos(){
        logOutBtn.frame = CGRect(x: self.view.frame.width * 0.12077294685990338, y: self.view.frame.height * 0.3247767857142857, width: self.view.frame.width * 0.7584541062801933, height: self.view.frame.height * 0.08258928571428571)
        deleteAccountBtn.frame = CGRect(x: self.view.frame.width * 0.12077294685990338, y: self.view.frame.height * 0.5915178571428571, width: self.view.frame.width * 0.7584541062801933, height: self.view.frame.height * 0.08258928571428571)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setViewPos()
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        signOutOrDelete = "log"
        
        performSegue(withIdentifier: "areYouSure", sender: self)
    }
    @IBAction func deleteAcc(_ sender: UIButton) {
        signOutOrDelete = "delete"
        
        performSegue(withIdentifier: "areYouSure", sender: self)
    }
}


class areYouSureVC: UIViewController{
    
    @IBOutlet weak var areYouSureLabel: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    
    func setUpViewPos(){
        areYouSureLabel.frame = CGRect(x: self.view.frame.width * 0.1280193236714976, y: self.view.frame.height * 0.05357142857142857, width: self.view.frame.width * 0.7439613526570048, height: self.view.frame.height * 0.08370535714285714)
        areYouSureLabel.adjustsFontSizeToFitWidth = true
        areYouSureLabel.minimumScaleFactor = 0.1
        areYouSureLabel.numberOfLines = 0
        areYouSureLabel.lineBreakMode = .byClipping
        
        noBtn.frame = CGRect(x: self.view.frame.width * 0.12077294685990338, y: self.view.frame.height * 0.3950892857142857, width: self.view.frame.width * 0.7584541062801933, height: self.view.frame.height * 0.08258928571428571)
        
        yesBtn.frame = CGRect(x: self.view.frame.width * 0.12077294685990338, y: self.view.frame.height * 0.5223214285714286, width: self.view.frame.width * 0.7584541062801933, height: self.view.frame.height * 0.08258928571428571)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpViewPos()
    }
    
    @IBAction func noBtnClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func yesbtnClicked(_ sender: UIButton) {
        
        if signOutOrDelete == "log"{
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                self.resetAllData()
                self.performSegue(withIdentifier: "logInAfter", sender: self)
            } catch let signOutError as NSError {
                self.dismiss(animated: true)
            }
        }
        
        else{
            let user = Auth.auth().currentUser
            
            user?.delete { error in
              if let error = error {
                  self.dismiss(animated: true)
              } else {
                  self.resetAllData()
                  self.performSegue(withIdentifier: "logInAfter", sender: self)
              }
            }
        }
        
    }
    
    func resetAllData(){
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}


