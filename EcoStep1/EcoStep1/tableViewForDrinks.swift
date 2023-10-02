//
//  tableViewForDrinks.swift
//  EcoStep1
//
//  Created by Федор on 09.01.2022.
//

import UIKit
var shoudlSegueBePerformedForDrinksTable = false
var allDrinks = [String]()
var allDrinksVolume = [Float]()


class tableViewForDrinks:UITableViewController{
    
    @IBOutlet var tableViewForDrinks: UITableView!
    
    var isSectionCollapsed = false
  
    var sectionNumber = -1
    
    var drinksAmount = 0

    
    var segueBool = Bool()
    override func viewWillDisappear(_ animated: Bool) {
        drinksAmount = allDrinks.count
        
    }
    override func viewWillAppear(_ animated: Bool) {
        segueBool = false
        tableViewForDrinks.dataSource = self
        tableViewForDrinks.delegate = self
        drinksAmount = allDrinks.count
        self.tableViewForDrinks.reloadData()
    }

    @IBOutlet var tableForMeals: UITableView!
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
//        view.layer.cornerRadius = 10
        
        let image = UIImageView(image: UIImage(named: "glass_of_milk"))
        image.frame = CGRect (x: 5, y: 5, width: 65, height: 65)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = "Drinks"
        label.frame = CGRect(x: 80, y: 5, width: 100, height: 65)
        view.addSubview(label)
        
        let widthOfView = view.frame.width
        
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: [])
        button.frame = CGRect(x:0.787292817679558*self.view.frame.width, y:0.008576329331046312*self.view.frame.height,width: 60,height: 60)
        button.tag = section
        button.tintColor =  UIColor(red: 0.396, green: 0.769, blue: 0.4, alpha: 1)
        
        button.addTarget(self, action: #selector(btnTouched(sender:)), for: .touchUpInside)
        
        view.addSubview(button)
        
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if drinksAmount == 0{
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
       
        return view
    }
    
    @objc func btnTouched(sender: UIButton) {
        shoudlSegueBePerformedForDrinksTable = true
        
    }
    
  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var drinksNum = allDrinks.count
        if isSectionCollapsed == true{
            return 1
        }
        else if drinksNum != 0 {
            drinksNum+=1
            return drinksNum
        }
        else{
            return drinksNum
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSectionCollapsed{
            let drinksEmissionClass = drinksEmission()
            let fullEmission = drinksEmissionClass.getFootprintForDrinks()
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "collapsedSec", for: indexPath)
            cell.textLabel?.text = "Your Drinks Footprint is \(fullEmission) kg"
            cell.backgroundColor = UIColor.white
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            let button = UIButton()
            button.setImage(UIImage(systemName: "arrowtriangle.down"), for: [])
            button.frame = CGRect(x:0.8238950276243094*self.view.frame.width, y:0.008576329331046312*self.view.frame.height, width: 38.5, height: 38.5)
            button.tag = indexPath.section
            button.addTarget(self, action: #selector(uncollpaseTable(sender: )), for: .touchUpInside)
            cell.addSubview(button)
            return cell
        }
        else if indexPath.row == drinksAmount {
            let cellForCollapse = tableView.dequeueReusableCell(withIdentifier: "collapseCell", for: indexPath)
            cellForCollapse.backgroundColor = UIColor.white
            cellForCollapse.layer.cornerRadius = 20
            cellForCollapse.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            let drinksEmissionClass = drinksEmission()
            let fullEmission = drinksEmissionClass.getFootprintForDrinks()
            cellForCollapse.textLabel?.text = "Your Drinks Footprint is \(fullEmission) kg"
            let button = UIButton()
            button.setImage(UIImage(systemName: "arrowtriangle.up"), for: [])
            button.frame = CGRect(x:0.8238950276243094*self.view.frame.width, y:0.008576329331046312*self.view.frame.height, width: 38.5, height: 38.5)
            button.tag = indexPath.section
            button.addTarget(self, action: #selector(collpaseTable(sender: )), for: .touchUpInside)
            cellForCollapse.addSubview(button)
            return cellForCollapse
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "drinksCell", for: indexPath)
            cell.layer.cornerRadius = 0
            cell.layer.maskedCorners = []
            cell.backgroundColor = UIColor.white
            let drinksCellText = "\(String(allDrinks[indexPath.row]).dropFirst(2)) \(allDrinksVolume[indexPath.row]) l"
            cell.textLabel?.text = drinksCellText
            return cell
        }
    }
    
    @objc func collpaseTable(sender: UIButton){
        let meal = sender.tag
        isSectionCollapsed = true
        tableViewForDrinks.reloadData()
    }
    @objc func uncollpaseTable(sender: UIButton){
        let meal = sender.tag
        isSectionCollapsed = false
        tableViewForDrinks.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allDrinks.remove(at: indexPath.row)
            allDrinksVolume.remove(at: indexPath.row)
            saveDef.set(allDrinks, forKey: "allDrinks")
            saveDef.set(allDrinksVolume, forKey: "allDrinksVolumeArray")
            saveDef.synchronize()
            drinksAmount = allDrinks.count

            tableViewForDrinks.reloadData()

         
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            
        }
    }
    
    
    
}
