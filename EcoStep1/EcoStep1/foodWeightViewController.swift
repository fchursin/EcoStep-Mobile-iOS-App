//
//  foodWeightViewController.swift
//  EcoStep1
//
//  Created by Федор on 31.01.2022.
//

import UIKit

class foodWeightViewController:UIViewController{

    @IBOutlet weak var backBtnBgView: UIView!
    @IBOutlet weak var sliderButton: UIButton!
    @IBOutlet weak var picesButton: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var sliderVC: UIView!
    
    @IBOutlet weak var piecesVC: UIView!
    
    var choosenMeal = ""
    
    func layoutAllViews(){
        backBtn.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        backBtnBgView.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        sliderButton.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.12723214285714285*self.view.frame.height, width:0.3502415458937198*self.view.frame.width,height:0.05580357142857143*self.view.frame.height)
        picesButton.frame = CGRect(x:0.6014492753623188*self.view.frame.width, y:0.12723214285714285*self.view.frame.height, width:0.3502415458937198*self.view.frame.width,height:0.05580357142857143*self.view.frame.height)
        sliderVC.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.19196428571428573*self.view.frame.height, width:0.9033816425120773*self.view.frame.width,height:0.7611607142857143*self.view.frame.height)
        piecesVC.frame = CGRect(x:0.04830917874396135*self.view.frame.width, y:0.19196428571428573*self.view.frame.height, width:0.9033816425120773*self.view.frame.width,height:0.7611607142857143*self.view.frame.height)
        
    }
    
    @IBAction func sliderTypeChoosen(_ sender: UIButton) {
        
        sliderButton.backgroundColor = UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1)
        sliderButton.setTitleColor(.white,for: .normal)
        
        picesButton.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        picesButton.setTitleColor( UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1), for: .normal)
        
        piecesVC.isHidden = true
        sliderVC.isHidden = false
    }
    @IBAction func picesTypeChoosen(_ sender: UIButton) {
        
        sliderButton.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        sliderButton.setTitleColor( UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1), for: .normal)
        
        picesButton.backgroundColor =  UIColor(red: 0.204, green: 0.780, blue: 0.349, alpha: 1)
        picesButton.setTitleColor(.white, for: .normal)
        
        piecesVC.isHidden = false
        sliderVC.isHidden = true
    }
    
    let foodEmissionVC = foodEmmission()
   
    
    func getMealType()->Int{
        var mealNumber = -1
        if currentMeal == "breakfast"{
            mealNumber = 0
        }
        else if currentMeal == "lunch"{
            mealNumber = 1
        }
        else if currentMeal == "dinner"{
            mealNumber = 2
        }
        else{
            mealNumber = 3
        }
        return mealNumber
    }
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()

//        getMealType()
//        choosenMeal = selectedFoodForWeight
//        foodForMeals[mealNumber].append(reformFoodStringForCalculations(choosenMeal: choosenMeal))
//        weightForMeals[mealNumber].append(1.0)
        
    }
   
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    let prefixses = ["ME","DA","EG","SE","CH","VE","FR","SD","PA","MB","CE","FI"]
    
    let foodWordsWithoutIndexsesAndSpaces = ["Lamb","Beef","Chicken","Pork", "Sausages","Turkey", "Bacon","Gammon","Goat","Ham","Rabbit","Scrambled eggs", "Eggs","Salmon","Trout", "Sardines", "Tuna","Seabass", "Anchovies","Halibut","Shrimps", "Mussels","Oysters", "Lobster","Scampi","Clams","Milk","Yougurt","Quark","Sour cream","Butter","Cheese","Mozzarella","Parmesan","Camamber","Cheddar","Feta","Mascarpone","Cucumber","Tomato","Carrot","Potato","Avocado","Peas","Corn","Broccoli","Artichoke","Asparagus","Cauliflower","Garlic","Lettuce","Cabbage","Apple","Banana","Orange","Pear","Kiwi","Watermelon","Grape","Strawberry","Apricot","Cherries","Lemons","Lime","Mangoes", "Papaya","Salad","Mashed potatoes","Pasta products","Rice","Chicken noodles","Boognese","Tomato pasta","Beef lasagne","Chicken roast","Lamb curry","Lamb roast","Pork with rice","Chicken curry","Oats","Muesli","Quinoa","Barley","Bulgar","Lentils","Polenta", "Wheat","Buckwheat"]
    
    func reformFoodStringForCalculations(choosenMeal:String)->String{
        var finalFoodString = ""
        if prefixses.contains(String(choosenMeal.prefix(2))){
            finalFoodString = choosenMeal
        }
        else if foodWordsWithoutIndexsesAndSpaces.contains(choosenMeal){
            var firstIndx = foodWordsWithoutIndexsesAndSpaces.firstIndex(of: choosenMeal)!
            if firstIndx > -1 && firstIndx<11{
                let indx = "ME"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>10 && firstIndx<13{
                let indx = "EG"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>12 && firstIndx<20{
                let indx = "FI"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>19 && firstIndx<26{
                let indx = "SE"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>25 && firstIndx<31{
                let indx = "DA"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>30 && firstIndx<38{
                let indx = "CH"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>37 && firstIndx<52{
                let indx = "VE"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>51 && firstIndx<66{
                let indx = "FR"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>65 && firstIndx<70{
                let indx = "SD"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>69 && firstIndx<74{
                let indx = "PA"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>73 && firstIndx<79{
                let indx = "MB"
                finalFoodString = indx + choosenMeal
            }
            else if firstIndx>78 && firstIndx<88{
                let indx = "CE"
                finalFoodString = indx + choosenMeal
            }
            else{
                print("Error")
            }
            

            
        }
        else{
            var spacePos = 0
            if let i = choosenMeal.firstIndex(of: " ") {
                spacePos = choosenMeal.distance(from: choosenMeal.startIndex, to: i)
            }
            
            switch String(choosenMeal.prefix(spacePos)){
            case "Meat":
                let indx = "ME"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "Egg":
                let indx = "EG"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "Fish":
                let indx = "FI"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "SeaFood":
                let indx = "SE"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "Dairy":
                let indx = "DA"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "Cheese":
                let indx = "CH"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "SideDish":
                let indx = "SD"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "Fruits":
                let indx = "FR"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "Vegetables":
                let indx = "VE"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "Pasta":
                let indx = "PA"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "MeatBased":
                let indx = "MB"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            case "Cereals":
                let indx = "CE"
                finalFoodString = indx + choosenMeal.suffix(choosenMeal.count-spacePos-1)
            default:
               
                print("Error")
            }
        }
        return finalFoodString
    }
    
}

class chooseWeightBySlideBarVC: UIViewController{
    
    func setArraysForFood(){
        
        foodForMeals = (saveDef.array(forKey: "foodForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        weightForMeals = (saveDef.array(forKey: "wieghtForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        
    }
    
    @IBOutlet weak var foodMassLabel: UILabel!
    @IBOutlet weak var sliderForMass: UISlider!

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var foodTypeLabek: UILabel!
    
    func layoutAllViews(){
        foodMassLabel.frame = CGRect(x:0.2620320855614973*self.view.frame.width, y:0.4002932551319648*self.view.frame.height, width:0.4786096256684492*self.view.frame.width,height:0.05278592375366569*self.view.frame.height)
        foodMassLabel.adjustsFontSizeToFitWidth = true
        foodMassLabel.minimumScaleFactor = 0.1
        foodMassLabel.numberOfLines = 0
        foodMassLabel.lineBreakMode = .byClipping
        sliderForMass.frame = CGRect(x:0.12566844919786097*self.view.frame.width, y:0.47947214076246336*self.view.frame.height, width:0.7486631016042781*self.view.frame.width,height:0.04398826979472141*self.view.frame.height)
        addBtn.frame = CGRect(x:0.3663101604278075*self.view.frame.width, y:0.8020527859237536*self.view.frame.height, width:0.26737967914438504*self.view.frame.width,height:0.06598240469208211*self.view.frame.height)
        foodTypeLabek.frame = CGRect(x:0.13101604278074866*self.view.frame.width, y:0.19501466275659823*self.view.frame.height, width:0.7379679144385026*self.view.frame.width,height:0.05278592375366569*self.view.frame.height)
        foodTypeLabek.adjustsFontSizeToFitWidth = true
        foodTypeLabek.minimumScaleFactor = 0.1
        foodTypeLabek.numberOfLines = 0
        foodTypeLabek.lineBreakMode = .byClipping
    }

    let foodWeightVC = foodWeightViewController()
    @IBAction func massDidChanged(_ sender: UISlider) {
        var foodMassString = String(sender.value).prefix(4)
        foodMassLabel.text = "\(foodMassString) kg"

    }

    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        allActions = saveDef.stringArray(forKey: "allActions") ?? []
        setArraysForFood()
        foodMassLabel.text = "\(sliderForMass.value) kg"
        var foodStr = foodWeightVC.reformFoodStringForCalculations(choosenMeal: selectedFoodForWeight)
        foodStr = String(foodStr[String.Index(encodedOffset: 2)...])
        foodTypeLabek.text = "\(foodStr)"
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        switch foodWeightVC.getMealType(){
        case 0:
            allActions.append("Breakfast")
        case 1:
            allActions.append("Lunch")
        case 2:
            allActions.append("Dinner")
        case 3:
            allActions.append("otherMeals")
        default:
            print("error")
        }
        foodForMeals[foodWeightVC.getMealType()].append(foodWeightVC.reformFoodStringForCalculations(choosenMeal: selectedFoodForWeight))
        weightForMeals[foodWeightVC.getMealType()].append(Double(String(sliderForMass.value).prefix(4))!)
        
        saveDef.set(allActions, forKey: "allActions")
        saveDef.set(foodForMeals, forKey: "foodForMealsArray")
        saveDef.set(weightForMeals, forKey: "wieghtForMealsArray")
        saveDef.synchronize()
        
        dismiss(animated: true, completion: nil)
    }

}

class chooseWeightByPieces: UIViewController{
    @IBOutlet weak var foodLabelType: UILabel!
    @IBOutlet weak var weightPer1pcs: UILabel!
    @IBOutlet weak var amountOfPcs: UILabel!
    @IBOutlet weak var pcsStepper: UIStepper!
    @IBOutlet weak var addBtn: UIButton!
    func setArraysForFood(){
        
        foodForMeals = (saveDef.array(forKey: "foodForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        weightForMeals = (saveDef.array(forKey: "wieghtForMealsArray") ?? [[],[],[],[]]) as! Array<Array<Any>>
        
    }
    
    func layoutAllViews(){
        foodLabelType.frame = CGRect(x:0.0427807486631016*self.view.frame.width, y:0.19501466275659823*self.view.frame.height, width:0.9144385026737968*self.view.frame.width,height:0.05278592375366569*self.view.frame.height)
        foodLabelType.adjustsFontSizeToFitWidth = true
        foodLabelType.minimumScaleFactor = 0.1
        foodLabelType.numberOfLines = 0
        foodLabelType.lineBreakMode = .byClipping
        weightPer1pcs.frame = CGRect(x:0.0427807486631016*self.view.frame.width, y:0.2595307917888563*self.view.frame.height, width:0.9171122994652406*self.view.frame.width,height:0.17595307917888564*self.view.frame.height)
        weightPer1pcs.adjustsFontSizeToFitWidth = true
        weightPer1pcs.minimumScaleFactor = 0.1
        weightPer1pcs.numberOfLines = 0
        weightPer1pcs.lineBreakMode = .byClipping
        amountOfPcs.frame = CGRect(x:0.39037433155080214*self.view.frame.width, y:0.4472140762463343*self.view.frame.height, width:0.1925133689839572*self.view.frame.width,height:0.04985337243401759*self.view.frame.height)
        amountOfPcs.adjustsFontSizeToFitWidth = true
        amountOfPcs.minimumScaleFactor = 0.1
        amountOfPcs.numberOfLines = 0
        amountOfPcs.lineBreakMode = .byClipping
        pcsStepper.frame = CGRect(x:0.37433155080213903*self.view.frame.width, y:0.5513196480938416*self.view.frame.height, width:0.25133689839572193*self.view.frame.width,height:0.0469208211143695*self.view.frame.height)
        addBtn.frame = CGRect(x:0.3663101604278075*self.view.frame.width, y:0.8020527859237536*self.view.frame.height, width:0.26737967914438504*self.view.frame.width,height:0.06598240469208211*self.view.frame.height)
    }
    
    let foodWeightVC = foodWeightViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
    
        allActions = saveDef.stringArray(forKey: "allActions") ?? []
        setArraysForFood()
        amountOfPcs.text = "\(Int(pcsStepper.value)) pcs"
        var foodStr = foodWeightVC.reformFoodStringForCalculations(choosenMeal: selectedFoodForWeight)
        foodStr = String(foodStr[String.Index(encodedOffset: 2)...])
        foodLabelType.text = "\(foodStr)"
        
        let checkerForMassPieces = checkIfThereIsPieceMass()
        if checkerForMassPieces == false{
            addBtn.isUserInteractionEnabled = false
            addBtn.alpha = 0.5
            weightPer1pcs.text = "Unfortunately there is no information about weight of one serving of \(foodStr)"
        }
        else{
            let weightClass = weightPerPiece()
            weightPer1pcs.text = "Particular weight for one serving of \(foodStr) is \( weightClass.weightPerPiece[foodWeightVC.reformFoodStringForCalculations(choosenMeal: selectedFoodForWeight)]!) kg"
        }
        
    }
    
    @IBAction func pcsChanged(_ sender: UIStepper) {
        amountOfPcs.text = "\(Int(pcsStepper.value)) pcs"
    }
    @IBAction func addBtn(_ sender: UIButton) {
        let weightClass = weightPerPiece()
        switch foodWeightVC.getMealType(){
        case 0:
            allActions.append("Breakfast")
        case 1:
            allActions.append("Lunch")
        case 2:
            allActions.append("Dinner")
        case 3:
            allActions.append("otherMeals")
        default:
            print("error")
        }
        foodForMeals[foodWeightVC.getMealType()].append(foodWeightVC.reformFoodStringForCalculations(choosenMeal: selectedFoodForWeight))
        weightForMeals[foodWeightVC.getMealType()].append(Double(pcsStepper.value)*weightClass.weightPerPiece[foodWeightVC.reformFoodStringForCalculations(choosenMeal: selectedFoodForWeight)]!)
        
        saveDef.set(allActions, forKey: "allActions")
        saveDef.set(foodForMeals, forKey: "foodForMealsArray")
        saveDef.set(weightForMeals, forKey: "wieghtForMealsArray")
        saveDef.synchronize()
        
        dismiss(animated: true, completion: nil)
    }
    
    func checkIfThereIsPieceMass()->Bool{
        let weightPcs = weightPerPiece()
        var isTherePiecesMass = false
        
        if weightPcs.weightPerPiece[foodWeightVC.reformFoodStringForCalculations(choosenMeal: selectedFoodForWeight)] != nil{
            isTherePiecesMass = true
        }
        
        return isTherePiecesMass
    }
}


