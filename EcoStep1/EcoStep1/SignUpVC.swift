//
//  SignUpVC.swift
//  EcoStep1
//
//  Created by Федор on 18.12.2021.
//

import UIKit
import Firebase


class SignUpVC: UIViewController,UITextFieldDelegate{
    
    
   
    @IBOutlet weak var signUpFinalBtn: UIButton!
    @IBOutlet weak var confirmPasLAbel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logInLine: UIProgressView!
    @IBOutlet weak var signUpLine: UIProgressView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var ecoStepiImage: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var whiteBoard: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confrimPasswordTextField: UITextField!
    
    @IBAction func LogInButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToLogInFromSignUp", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confrimPasswordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func layoutAllViews(){
        signUpFinalBtn.frame = CGRect(x:0.12077294685990338*self.view.frame.width, y:0.8794642857142857*self.view.frame.height, width:0.7584541062801933*self.view.frame.width,height:0.08258928571428571*self.view.frame.height)
        confirmPasLAbel.frame = CGRect(x:0.11594202898550725*self.view.frame.width, y:0.6015625*self.view.frame.height, width:0.3864734299516908*self.view.frame.width,height:0.0234375*self.view.frame.height)
        confirmPasLAbel.adjustsFontSizeToFitWidth = true
        passwordLabel.frame = CGRect(x:0.11594202898550725*self.view.frame.width, y:0.5189732142857143*self.view.frame.height, width:0.20772946859903382*self.view.frame.width,height:0.0234375*self.view.frame.height)
        passwordLabel.adjustsFontSizeToFitWidth = true
        emailLabel.frame = CGRect(x:0.11594202898550725*self.view.frame.width, y:0.43638392857142855*self.view.frame.height, width:0.11835748792270531*self.view.frame.width,height:0.0234375*self.view.frame.height)
        emailLabel.adjustsFontSizeToFitWidth = true
        logInLine.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.3861607142857143*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.004464285714285714*self.view.frame.height)
        signUpLine.frame = CGRect(x:0.5410628019323671*self.view.frame.width, y:0.3861607142857143*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.004464285714285714*self.view.frame.height)
        signUpBtn.frame = CGRect(x:0.5410628019323671*self.view.frame.width, y:0.34263392857142855*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.05915178571428571*self.view.frame.height)
        logInBtn.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.34263392857142855*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.05915178571428571*self.view.frame.height)
        ecoStepiImage.frame = CGRect(x:0.4855072463768116*self.view.frame.width, y:0.049107142857142856*self.view.frame.height, width:0.4178743961352657*self.view.frame.width,height:0.17522321428571427*self.view.frame.height)
        greetingLabel.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.049107142857142856*self.view.frame.height, width:0.35990338164251207*self.view.frame.width,height:0.07366071428571429*self.view.frame.height)
        greetingLabel.adjustsFontSizeToFitWidth = true
        whiteBoard.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.42745535714285715*self.view.frame.height)
        emailTextField.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.4720982142857143*self.view.frame.height, width:0.7318840579710145*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
        passwordTextField.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.5546875*self.view.frame.height, width:0.7318840579710145*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
        confrimPasswordTextField.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.6372767857142857*self.view.frame.height, width:0.7318840579710145*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        if passwordTextField.text != confrimPasswordTextField.text{
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                (user, error) in
                 if error == nil {
                     
                   self.performSegue(withIdentifier: "goToMainScreenSignUp", sender: self)
                     saveDef.set(true, forKey: "isLoggedIn")
                     saveDef.synchronize()
                                }
                 else{
                   let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                   let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                       }
            }
        }
        
        
    }
    
}
