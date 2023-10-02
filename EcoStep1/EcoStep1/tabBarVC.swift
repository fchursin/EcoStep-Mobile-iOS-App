//
//  tabBarVC.swift
//  EcoStep1
//
//  Created by Федор on 30.04.2022.
//

import UIKit

class tabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        if saveDef.bool(forKey: "firstLaunch") == false{
//            print("falseeee")
//            performSegue(withIdentifier: "onBoardSegue", sender: self)
//        }
////        self.viewControllers = [mainScreenVC(),actionsVC(),treeksViewController()]
        // Do any additional setup after loading the view.
    }
    func setToFirstScreen(){
        self.selectedIndex = 0

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
