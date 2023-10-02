//
//  ViewController.swift
//  EcoStep1
//
//  Created by Федор on 18.12.2021.
//

import UIKit
import SwiftUI
import Firebase


var globalVarDeviceModelName = ""

class ViewController: UIViewController {

    @IBOutlet weak var whiteBall: UIImageView!
    @IBOutlet weak var lightBlueBall: UIImageView!
    @IBOutlet weak var purpleBall: UIImageView!
    @IBOutlet weak var blueBall: UIImageView!
    @IBOutlet weak var phraseLabel: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var EcoStepHeader: UILabel!
    @IBOutlet weak var LogInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let modelName = UIDevice.modelName
        globalVarDeviceModelName =  reformDeviceName().reformDeviceString(deviceName: modelName)
        }
    
    func layoutAllViews(){
        phraseLabel.frame = CGRect(x:0.32367149758454106*self.view.frame.width, y:0.1953125*self.view.frame.height, width:0.3526570048309179*self.view.frame.width,height:0.14955357142857142*self.view.frame.height)
        phraseLabel.adjustsFontSizeToFitWidth = true
        whiteBall.frame = CGRect(x:0.5169082125603864*self.view.frame.width, y:0.3794642857142857*self.view.frame.height, width:0.35507246376811596*self.view.frame.width,height:0.1640625*self.view.frame.height)
        lightBlueBall.frame = CGRect(x:0.7536231884057971*self.view.frame.width, y:0.18861607142857142*self.view.frame.height, width:0.2898550724637681*self.view.frame.width,height:0.1640625*self.view.frame.height)
        purpleBall.frame = CGRect(x:0.644927536231884*self.view.frame.width, y:0.0*self.view.frame.height, width:0.35507246376811596*self.view.frame.width,height:0.13950892857142858*self.view.frame.height)
        blueBall.frame = CGRect(x:-0.06763285024154589*self.view.frame.width, y:0.29575892857142855*self.view.frame.height, width:0.35507246376811596*self.view.frame.width,height:0.1640625*self.view.frame.height)
        SignUpButton.frame = CGRect(x:0.13043478260869565*self.view.frame.width, y:0.5524553571428571*self.view.frame.height, width:0.7415458937198067*self.view.frame.width,height:0.18303571428571427*self.view.frame.height)
        EcoStepHeader.frame = CGRect(x:0.13043478260869565*self.view.frame.width, y:0.07924107142857142*self.view.frame.height, width:0.46618357487922707*self.view.frame.width,height:0.0703125*self.view.frame.height)
        EcoStepHeader.adjustsFontSizeToFitWidth = true
        LogInButton.frame = CGRect(x:0.13043478260869565*self.view.frame.width, y:0.7444196428571429*self.view.frame.height, width:0.7415458937198067*self.view.frame.width,height:0.18303571428571427*self.view.frame.height)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
    }
    
    override func viewDidAppear(_ animated: Bool){
     super.viewDidAppear(animated)
       
     let modelName = UIDevice.modelName
    globalVarDeviceModelName =  reformDeviceName().reformDeviceString(deviceName: modelName)
     if Auth.auth().currentUser != nil {
       self.performSegue(withIdentifier: "goToMainScreenLogedIn", sender: nil)
         saveDef.set(true, forKey: "isLoggedIn")
         saveDef.synchronize()
    }
    }
    
    @IBAction func SignUpButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUp", sender: self)
    }
    @IBAction func LogInButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogIn", sender: self)
    }
    

}

class reformDeviceName{
    func reformDeviceString(deviceName:String)->String{
        var deviseStr = ""
        let arrDevise = deviceName.split(separator: " ")
        if arrDevise[0] == "Simulator"{
            for i in 2..<arrDevise.count{
                deviseStr += arrDevise[i]
            }
        }
        else{
            for i in 1..<arrDevise.count{
                deviseStr += arrDevise[i]
            }
        }
        
        return deviseStr
    }
}
