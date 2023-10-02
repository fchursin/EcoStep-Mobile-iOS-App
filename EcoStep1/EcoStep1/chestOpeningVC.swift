//
//  chestOpeningVC.swift
//  EcoStep1
//
//  Created by Федор on 12.04.2022.
//

import UIKit

var droppedCards:Array<String> = []

class chetsOpeningVC:UIViewController{
    @IBOutlet weak var chestImage: UIImageView!
    
    @IBOutlet weak var cardsLeftLabel: UILabel!
    var amountOfCardDrop = 0
    
    func layoutAllViews(){
        chestImage.frame = CGRect(x:0.2584541062801932*self.view.frame.width, y:0.7366071428571429*self.view.frame.height, width:0.4830917874396135*self.view.frame.width,height:0.22321428571428573*self.view.frame.height)
        cardsLeftLabel.frame = CGRect(x:0.2995169082125604*self.view.frame.width, y:0.11383928571428571*self.view.frame.height, width:0.40096618357487923*self.view.frame.width,height:0.04017857142857143*self.view.frame.height)
        cardsLeftLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        setImageAndPrepareForOpening()
        cardsLeftLabel.text = "Cards Left: \(amountOfCardDrop)"
        droppedCards = []
        
        if amountOfCardDrop > 0 {
            amountOfCardDrop -= 1
            UIView.animate(withDuration: 0.25){ self.getAndAnimateACard()}
            
           
        }
    }
    func setImageAndPrepareForOpening(){
        switch curretnChoosenChestToOpen{
        case "small":
            chestImage.image = UIImage(named: "smallChestOpened")
            amountOfCardDrop = 3
        case "medium":
            chestImage.image = UIImage(named: "mediumChestOpened2")
            amountOfCardDrop = 5
        case "big":
            chestImage.image = UIImage(named: "bigChestOpened3")
            amountOfCardDrop = 9
        default:
            print("error")
        }
    }
    
    func getAndAnimateACard(){
        let width = 275.0
        let height = 450.0
        
        
        
        let cardImage = UIImageView(frame: CGRect(x: -width, y: self.view.frame.midY-height/2, width: 0, height: 0))
        
        let cardsNames = ["ecoCupCard","ecoCupCard","ecoCupCard","ecoCupCard","ecoCupCard","carCard","carCard","carCard","questionMarkCard","questionMarkCard"]
        
        let cardName = cardsNames.randomElement()!
        droppedCards.append(cardName)
        
        cardImage.image = UIImage(named: cardName)
        cardImage.frame = CGRect(x:0.2785829307568438*self.view.frame.width, y:0.3325892857142857*self.view.frame.height, width:0.4428341384863124*self.view.frame.width,height:0.33482142857142855*self.view.frame.height)
        
        
        self.view.addSubview(cardImage)
        cardsLeftLabel.text = "Cards Left: \(amountOfCardDrop)"
    }
    
    @IBAction func screenTapped(_ sender: UIButton) {
        if amountOfCardDrop > 0 {
            amountOfCardDrop -= 1
            UIView.animate(withDuration: 0.5){ self.getAndAnimateACard()}
           
        }
        else if amountOfCardDrop <= 0 {
            saveDef.set(droppedCards, forKey: "droppedCards")
            dismiss(animated: true, completion: nil)
        }
    }
    
}
