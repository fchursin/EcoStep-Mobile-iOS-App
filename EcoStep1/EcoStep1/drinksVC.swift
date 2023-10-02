//
//  drinksVC.swift
//  EcoStep1
//
//  Created by Федор on 09.01.2022.
//

import UIKit

struct Drinks{
    var DrinksType:String
    var DrinksInType: Array<String>
}

var choosenDrink = ""

var shouldSegueToVolumeSetterBePerformed = false

class drinksVC:UITableViewController,UISearchBarDelegate{
    @IBOutlet weak var searchController: UISearchBar!
    @IBOutlet var tableViewE: UITableView!
    
    
    
    var listNumber = -1
    
    var number = 1231
    
    var isSearching = false
    
    var searchedDrinks = [String]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        searchController.delegate = self

    }
    
    
    let drinksForTableViewWithSections = [
       Drinks(DrinksType: "Tea", DrinksInType: ["TEBlack Tea","TEGreen Tea","TEHerbal Tea","TEJasmin Tea"]),
       Drinks(DrinksType: "Coffee", DrinksInType: ["COAmericano","COCappuccino","COEspresso","COBlack Coffee","COFlat White","COLatte","COMocha"]),
       Drinks(DrinksType: "Juices", DrinksInType: ["JUApple Juice","JUOrange Juice","JUGrapefruit Juice","JUFruit Juice","JULime Juice","JUPineapple Juice"]),
//       Drinks(DrinksType: "Alcoholic Beverages", DrinksInType: ["Beer","Wine","Wiskey"])
    ]
    
    let drinksForsearchbar = ["Black Tea","Green Tea","Herbal Tea","Jasmin Tea","Americano","Cappuccino","Espresso","Black Coffee","Flat White","Latte","Mocha","Apple Juice","Orange Juice","Grapefruit Juice","Fruit Juice","Lime Juice","Pineapple Juice","Tea Black Tea","Tea Green Tea","Tea Herbal Tea","Tea Jasmin Tea","Coffee Americano","Coffee Cappuccino","Coffee Espresso","Coffee Black Coffee","Coffee Flat White","Coffee Latte","Coffee Mocha","Juice Apple Juice","Juice Orange Juice","Juice Grapefruit Juice","Juice Fruit Juice","Juice Lime Juice","Juice Pineapple Juice"]
   
    let prefixes = ["TE","CO","JU"]
    
    let drinksWithSpaceInIt = ["Herbal Tea","Black Tea","Green Tea","Oranje Juice","Apple Juice","Tomato Juice","Pineapple Juice","Jasmin Tea","Black Coffee","Flat White","Grapefruit Juice"]

    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var sectionsNum = 1
        if isSearching == false{
            sectionsNum =  drinksForTableViewWithSections.count
        }
        return sectionsNum
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var returnString = "You are looking for..."
        if isSearching == false{
            returnString =  drinksForTableViewWithSections[section].DrinksType
        }
       return returnString
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if isSearching == false{
            numberOfRows = drinksForTableViewWithSections[section].DrinksInType.count
        }
        else{
            numberOfRows = searchedDrinks.count
        }
        return numberOfRows
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as UITableViewCell
        
        if isSearching == false {
            if prefixes.contains(String(drinksForTableViewWithSections[indexPath.section].DrinksInType[indexPath.row].prefix(2))){
                cell.textLabel?.text = String(drinksForTableViewWithSections[indexPath.section].DrinksInType[indexPath.row].dropFirst(2))
            }
            else{
            cell.textLabel?.text = drinksForTableViewWithSections[indexPath.section].DrinksInType[indexPath.row]
            }
        }
        else{
            if searchedDrinks[indexPath.row].firstIndex(of: " ") == nil{
                cell.textLabel?.text = searchedDrinks[indexPath.row]
            }
            else if drinksWithSpaceInIt.contains(searchedDrinks[indexPath.row]){
                cell.textLabel?.text = searchedDrinks[indexPath.row]
            }
            else{
                var spacePos = 0
                if let i = searchedDrinks[indexPath.row].firstIndex(of: " ") {
                    spacePos = searchedDrinks[indexPath.row].distance(from: searchedDrinks[indexPath.row].startIndex, to: i)
                }
                cell.textLabel?.text = String(searchedDrinks[indexPath.row].dropFirst(spacePos+1))
            }
        
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching == false{
            let selectedRow = drinksForTableViewWithSections[indexPath.section].DrinksInType[indexPath.row]
           
            choosenDrink = selectedRow
            shouldSegueToVolumeSetterBePerformed = true
          tableView.deselectRow(at: indexPath, animated: false)
            navigationController?.popToRootViewController(animated: true)
//            print(foodForMeals)
//            navigationController?.popToViewController(drinksActionVC(), animated: true)
//            navigationController?.popViewController(animated: true)
//            dismiss(animated: true, completion: nil)
         
        }
        else{
            let selectedRow = searchedDrinks[indexPath.row]
       
            choosenDrink = selectedRow
            shouldSegueToVolumeSetterBePerformed = true
            tableView.deselectRow(at: indexPath, animated: false)
            _ = navigationController?.popViewController(animated: true)
//            dismiss(animated: true, completion: nil)
        }
            
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedDrinks = drinksForsearchbar.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
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


class viewControllerForDrinksAndBackButton:UIViewController{
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backBtnBgView: UIView!
    @IBOutlet weak var tableViewHolder: UIView!
    
    var timer = Timer()
    
    func layoutAllViews(){
        backBtn.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        backBtnBgView.frame = CGRect(x:0.0*self.view.frame.width, y:0.0*self.view.frame.height, width:1.0*self.view.frame.width,height:0.09821428571428571*self.view.frame.height)
        tableViewHolder.frame = CGRect(x:0.0*self.view.frame.width, y:0.09821428571428571*self.view.frame.height, width:1.0*self.view.frame.width,height:0.9017857142857143*self.view.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(performSegueToDrinkVolume), userInfo: nil, repeats: true)
    }
    
    @objc func performSegueToDrinkVolume(){
        if shouldSegueToVolumeSetterBePerformed{
            performSegue(withIdentifier: "goToWeightSetter", sender: self)
            shouldSegueToVolumeSetterBePerformed = false
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
}
