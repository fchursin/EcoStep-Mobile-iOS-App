//
//  FoodVC.swift
//  EcoStep1
//
//  Created by Федор on 28.12.2021.
//

import UIKit

struct Food{
    var FoodCat: String
    var FoodClass: Array<String>
}

var selectedFoodForWeight = ""
var shouldPerformSegueToweightChooser = false


class FoodVC:UITableViewController,UISearchBarDelegate {
    @IBOutlet weak var searchController: UISearchBar!
    @IBOutlet var tableViewE: UITableView!
    
    
    var foodList = [[],[],[],[]]
    
    var listNumber = -1
    
    var number = 1231
    
    var isSearching = false
    
    var searchedFood = [String]()
    
    func getMealType(){
        if currentMeal == "breakfast"{
            listNumber = 0
        }
        else if currentMeal == "lunch"{
            listNumber = 1
        }
        else if currentMeal == "dinner"{
            listNumber = 2
        }
        else{
            listNumber = 3
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchController.delegate = self

        getMealType()
        
//        searchController.showsCancelButton = true
    }
    
    let foodForTableViewWithSections = [
        Food(FoodCat: "Meat", FoodClass: ["MELamb","MEBeef","MEChicken","MEPork", "MESausages","METurkey", "MEBacon","MEGammon","MEGoat","MEHam","MERabbit"]),
        Food(FoodCat: "Eggs", FoodClass: ["EGScrambled eggs", "EGEggs"]),
        Food(FoodCat: "Fish", FoodClass: ["FISalmon","FITrout", "FISardines", "FITuna","FISeabass", "FIAnchovies","FIHalibut"]),
        Food(FoodCat: "Sea Food", FoodClass: ["SEShrimps", "SEMussels","SEOysters", "SELobster","SEScampi","SEClams"]),
        Food(FoodCat:"Dairy Products", FoodClass: ["DAMilk","DAYougurt","DAQuark","DASour cream","DAButter"]),
        Food(FoodCat: "Cheese", FoodClass: ["CHCheese","CHMozzarella","CHParmesan","CHCamamber","CHCheddar","CHFeta","CHMascarpone"]),
        Food(FoodCat: "Vegetables", FoodClass: ["VECucumber","VETomato","VECarrot","VEPotato","VEAvocado","VEPeas","VECorn","VEBroccoli","VEArtichoke","VEAsparagus","VECauliflower","VEGarlic","VELettuce","VECabbage"]),
        Food(FoodCat: "Fruits", FoodClass: ["FRApple","FRBanana","FROrange","FRPear","FRKiwi","FRWatermelon","FRGrape","FRStrawberry","FRApricot","FRCherries","FRLemons","FRLime","FRMangoes", "FRPapaya"]),
        Food(FoodCat: "Side Dishes", FoodClass: ["SDSalad","SDMashed potatoes","SDPasta products","SDRice"]),
        Food(FoodCat: "Pasta", FoodClass: ["PAChicken noodles","PABoognese","PATomato pasta","PABeef lasagne"]),
        Food(FoodCat: "Meat Based Meals", FoodClass: ["MBChicken roast","MBLamb curry","MBLamb roast","MBPork with rice","MBChicken curry"]),
        Food(FoodCat: "Cereals", FoodClass: ["CEOats","CEMuesli","CEQuinoa","CEBarley","CEBulgar","CELentils","CEPolenta", "CEWheat","CEBuckwheat"])
    ]
    
    let foodForsearchbar = ["Lamb","Beef","Chicken","Pork", "Sausages","Turkey", "Bacon","Gammon","Goat","Ham","Rabbit","Scrambled eggs", "Eggs","Salmon","Trout", "Sardines", "Tuna","Seabass", "Anchovies","Halibut","Shrimps", "Mussels","Oysters", "Lobster","Scampi","Clams","Milk","Yougurt","Quark","Sour cream","Butter","Cheese","Mozzarella","Parmesan","Camamber","Cheddar","Feta","Mascarpone","Cucumber","Tomato","Carrot","Potato","Avocado","Peas","Corn","Broccoli","Artichoke","Asparagus","Cauliflower","Garlic","Lettuce","Cabbage","Apple","Banana","Orange","Pear","Kiwi","Watermelon","Grape","Strawberry","Apricot","Cherries","Lemons","Lime","Mangoes", "Papaya","Salad","Mashed potatoes","Pasta products","Rice","Chicken noodles","Boognese","Tomato pasta","Beef lasagne","Chicken roast","Lamb curry","Lamb roast","Pork with rice","Chicken curry","Oats","Muesli","Quinoa","Barley","Bulgar","Lentils","Polenta", "Wheat","Buckwheat","Meat Lamb","Meat Beef","Meat Chicken","Meat Pork", "Meat Sausages","Meat Turkey", "Meat Bacon","Meat Gammon","Meat Goat","Meat Ham","Meat Rabbit","Egg Scrambled eggs", "Egg Eggs","Fish Salmon","Fish Trout", "Fish Sardines", "Fish Tuna","Fish Seabass", "Fish Anchovies","Fish Halibut","SeaFood Shrimps", "SeaFood Mussels","SeaFood Oysters", "SeaFood Lobster","SeaFood Scampi","SeaFood Clams","Dairy Milk","Dairy Yougurt","Dairy Quark","Dairy Sour cream","Dairy Butter","Cheese Cheese","Cheese Mozzarella","Cheese Parmesan","Cheese Camamber","Cheese Cheddar","Cheese Feta","Cheese Mascarpone","Vegetables Cucumber","Vegetables Tomato","Vegetables Carrot","Vegetables Potato","Vegetables Avocado","Vegetables Peas","Vegetables Corn","Vegetables Broccoli","Vegetables Artichoke","Vegetables Asparagus","Vegetables Cauliflower","Vegetables Garlic","Vegetables Lettuce","Vegetables Cabbage","Fruits Apple","Fruits Banana","Fruits Orange","Fruits Pear","Fruits Kiwi","Fruits Watermelon","Fruits Grape","Fruits Strawberry","Fruits Apricot","Fruits Cherries","Fruits Lemons","Fruits Lime","Fruits Mangoes", "Fruits Papaya","SideDish Salad","SideDish Mashed potatoes","SideDish Pasta products","SideDish Rice","Pasta Chicken noodles","Pasta Boognese","Pasta Tomato pasta","Pasta Beef lasagne","MeatBased Chicken roast","MeatBased Lamb curry","MeatBased Lamb roast","MeatBased Pork with rice","MeatBased Chicken curry","Cereals Oats","Cereals Muesli","Cereals Quinoa","Cereals Barley","Cereals Bulgar","Cereals Lentils","Cereals Polenta", "Cereals Wheat","Cereals Buckwheat"]
   
    let prefixses = ["ME","DA","EG","SE","CH","VE","FR","SD","PA","MB","CE","FI"]
    
    let foodWithSpaceInIt = ["Mashed potatoes","Pasta products","Chicken noodles","Tomato pasta","Beef lasagne","Chicken roast","Lamb curry","Lamb roast","Pork with rice","Chicken curry","Sour cream","Scrambled eggs"]
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var sectionsNum = 1
        if isSearching == false{
            sectionsNum =  foodForTableViewWithSections.count
        }
        return sectionsNum
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var returnString = "You are looking for..."
        if isSearching == false{
            returnString =  foodForTableViewWithSections[section].FoodCat
        }
       return returnString
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if isSearching == false{
            numberOfRows = foodForTableViewWithSections[section].FoodClass.count
        }
        else{
            numberOfRows = searchedFood.count
        }
        return numberOfRows
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as UITableViewCell
        
        if isSearching == false {
            if prefixses.contains(String(foodForTableViewWithSections[indexPath.section].FoodClass[indexPath.row].prefix(2))){
                cell.textLabel?.text = String(foodForTableViewWithSections[indexPath.section].FoodClass[indexPath.row].dropFirst(2))
            }
            else{
            cell.textLabel?.text = foodForTableViewWithSections[indexPath.section].FoodClass[indexPath.row]
            }
        }
        else{
            if searchedFood[indexPath.row].firstIndex(of: " ") == nil{
                cell.textLabel?.text = searchedFood[indexPath.row]
            }
            else if foodWithSpaceInIt.contains(searchedFood[indexPath.row]){
                cell.textLabel?.text = searchedFood[indexPath.row]
            }
            else{
                var spacePos = 0
                if let i = searchedFood[indexPath.row].firstIndex(of: " ") {
                    spacePos = searchedFood[indexPath.row].distance(from: searchedFood[indexPath.row].startIndex, to: i)
                }
                cell.textLabel?.text = String(searchedFood[indexPath.row].dropFirst(spacePos+1))
            }
        
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching == false{
            selectedFoodForWeight = foodForTableViewWithSections[indexPath.section].FoodClass[indexPath.row]
            let selectedRow = foodForTableViewWithSections[indexPath.section].FoodClass[indexPath.row]

//            foodForMeals[listNumber].append(selectedRow)
            shouldPerformSegueToweightChooser = true
            tableView.deselectRow(at: indexPath, animated: false)

//            dismiss(animated: true, completion: nil)
        }
        else{
            selectedFoodForWeight = searchedFood[indexPath.row]
            let selectedRow = searchedFood[indexPath.row]
     
//            foodForMeals[listNumber].append(selectedRow)
            shouldPerformSegueToweightChooser = true
            tableView.deselectRow(at: indexPath, animated: false)
//            dismiss(animated: true, completion: nil)
        }
            
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchedFood = foodForsearchbar.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
            isSearching = true
            tableViewE.reloadData()
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
                self.view.endEditing(true)
                self.isSearching = false
                searchBar.text = ""
                self.tableViewE.reloadData()
            }
        }
//            if searchText == "" {
//                self.view.endEditing(true)
//                isSearching = false
//                searchBar.text = ""
//                tableViewE.reloadData()
//            }
        }
    
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            isSearching = false
            searchBar.text = ""
            tableViewE.reloadData()
            self.view.endEditing(true)

        }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
 
   
   
}

class foodVCForTableAndBackButton:UIViewController{
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableViewHolder: UIView!
    @IBOutlet weak var backBtnBgView: UIView!
    
    var timer = Timer()
    
    func layoutAllViews(){
        backBtn.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        backBtnBgView.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        tableViewHolder.frame = CGRect(x:0.0*self.view.frame.width, y:0.09821428571428571*self.view.frame.height, width:1.0*self.view.frame.width,height:0.9017857142857143*self.view.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(performSegueToFoodWeight), userInfo: nil, repeats: true)
    }
    
    @objc func performSegueToFoodWeight(){
        if shouldPerformSegueToweightChooser{
            performSegue(withIdentifier: "goToWeightSetter", sender: self)
            shouldPerformSegueToweightChooser = false
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
}

