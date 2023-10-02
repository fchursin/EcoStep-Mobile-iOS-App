//
//  LogInVC.swift
//  EcoStep1
//
//  Created by Федор on 18.12.2021.
//

import UIKit
import Firebase
import GoogleSignIn


class LogInVC: UIViewController,UITextFieldDelegate{
 
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logInLine: UIProgressView!
    @IBOutlet weak var signUpLine: UIProgressView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var whiteBoard: UIImageView!
    @IBOutlet weak var ecoStepImage: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordLabel: UIButton!
    @IBOutlet weak var logInFinalBtn: UIButton!
    
    @IBAction func SignUpButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUpFromLogIn", sender: self)
    }
    @IBAction func forgotPasswordBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToForgotPage", sender: self)
    }


    
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func layoutAllViews(){
        logInFinalBtn.frame = CGRect(x:0.12077294685990338*self.view.frame.width, y:0.8794642857142857*self.view.frame.height, width:0.7584541062801933*self.view.frame.width,height:0.08258928571428571*self.view.frame.height)
        passwordLabel.frame = CGRect(x:0.11594202898550725*self.view.frame.width, y:0.5189732142857143*self.view.frame.height, width:0.20772946859903382*self.view.frame.width,height:0.0234375*self.view.frame.height)
        passwordLabel.adjustsFontSizeToFitWidth = true
        emailLabel.frame = CGRect(x:0.11594202898550725*self.view.frame.width, y:0.43638392857142855*self.view.frame.height, width:0.11835748792270531*self.view.frame.width,height:0.0234375*self.view.frame.height)
        emailLabel.adjustsFontSizeToFitWidth = true
        logInLine.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.3861607142857143*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.004464285714285714*self.view.frame.height)
        signUpLine.frame = CGRect(x:0.5410628019323671*self.view.frame.width, y:0.3861607142857143*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.004464285714285714*self.view.frame.height)
        signUpBtn.frame = CGRect(x:0.5410628019323671*self.view.frame.width, y:0.34263392857142855*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.05915178571428571*self.view.frame.height)
        logInBtn.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.34263392857142855*self.view.frame.height, width:0.36231884057971014*self.view.frame.width,height:0.05915178571428571*self.view.frame.height)
        ecoStepImage.frame = CGRect(x:0.4855072463768116*self.view.frame.width, y:0.049107142857142856*self.view.frame.height, width:0.4178743961352657*self.view.frame.width,height:0.17522321428571427*self.view.frame.height)
        greetingLabel.frame = CGRect( x:0.04830917874396135*self.view.frame.width, y:0.049107142857142856*self.view.frame.height, width:0.3743961352657005*self.view.frame.width,height:0.14732142857142858*self.view.frame.height)
        greetingLabel.adjustsFontSizeToFitWidth = true
        whiteBoard.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.42745535714285715*self.view.frame.height)
        passwordTextField.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.4720982142857143*self.view.frame.height, width:0.7318840579710145*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
        emailTextField.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.5546875*self.view.frame.height, width:0.7318840579710145*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
        forgotPasswordLabel.frame = CGRect(x:0.09903381642512077*self.view.frame.width, y:0.6104910714285714*self.view.frame.height, width:0.4323671497584541*self.view.frame.width,height:0.05133928571428571*self.view.frame.height)
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: passwordTextField.text!, password: emailTextField.text!) { (user, error) in
           if error == nil{
             self.performSegue(withIdentifier: "goToMainScreenLogIn", sender: self)
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


class forgotPasswordVC:UIViewController,UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBOutlet weak var backBgView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    func layoutAllViews(){
        backBgView.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        backBtn.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        forgotPasswordLabel.frame = CGRect(x:0.1280193236714976*self.view.frame.width, y:0.38839285714285715*self.view.frame.height, width:0.7439613526570048*self.view.frame.width,height:0.08370535714285714*self.view.frame.height)
        forgotPasswordLabel.adjustsFontSizeToFitWidth = true
        emailTextField.frame = CGRect(x:0.1280193236714976*self.view.frame.width, y:0.4810267857142857*self.view.frame.height, width:0.7439613526570048*self.view.frame.width,height:0.03794642857142857*self.view.frame.height)
        sendBtn.frame = CGRect(x:0.12077294685990338*self.view.frame.width, y:0.8125*self.view.frame.height, width:0.7584541062801933*self.view.frame.width,height:0.08258928571428571*self.view.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        emailTextField.delegate = self
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if let error = error {
                
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert,animated: true,completion: nil)
                
                return
            }
            let alert = UIAlertController(title: "Success", message:"A password reset email has been sent", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert,animated: true,completion: nil)
            self.dismiss(animated: true)
        }
    }
}
