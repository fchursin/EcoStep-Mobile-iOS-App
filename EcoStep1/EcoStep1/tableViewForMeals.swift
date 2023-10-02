//
//  TableViewController.swift
//  EcoStep1
//
//  Created by Федор on 02.01.2022.
//

import UIKit

var shoudlSegueBePerformedForFoodTable = false
var foodForMeals = [[],[],[],[]]
var weightForMeals = [[],[],[],[]]
var currentMeal = ""


class tableViewForMeals: UITableViewController {
    
  
    let foodFootprintClass = foodEmmission()
    
    var breakfastEmission:Double = 0.0
    var lunchEmission:Double = 0.0
    var dinnerEmission:Double = 0.0
    var otherMealsEmission:Double = 0.0
    
    
   
    var mealFootprint:Array<String> = []
    
    var isSectionCollapsed = [false,false,false,false]
  
    
    let images = ["fried_egg","stew","shallow_pan_of_food","knife_fork_plate"]
    let sections = ["Breakfast","Lunch","Dinner","Other Meals"]
    

    
    var sectionNumber = -1
    
    let letMealsStr = ["breakfast","lunch","dinner","otherMeals"]
    
    var lastRow = [Int]()
    
    var segueBool = Bool()
    override func viewWillDisappear(_ animated: Bool) {
   
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setAllFootprintTitles()
        segueBool = false
        appendAmountOfRowsAndSetAllForTableData()
    }
    
    func appendAmountOfRowsAndSetAllForTableData(){
        tableForMeals.dataSource = self
        tableForMeals.delegate = self
        lastRow = []
        lastRow.append(foodForMeals[0].count)
        lastRow.append(foodForMeals[1].count)
        lastRow.append(foodForMeals[2].count)
        lastRow.append(foodForMeals[3].count)
        self.tableForMeals.reloadData()
    }
    
    func setAllFootprintTitles(){
        breakfastEmission = foodFootprintClass.getFootprintForCurrentMeal(mealType: 0)
        lunchEmission = foodFootprintClass.getFootprintForCurrentMeal(mealType: 1)
        dinnerEmission = foodFootprintClass.getFootprintForCurrentMeal(mealType: 2)
        otherMealsEmission = foodFootprintClass.getFootprintForCurrentMeal(mealType: 3)
        
        mealFootprint = ["Breakfast footprint - \(breakfastEmission) kg/co2","Lunch footprint - \(lunchEmission) kg/co2","Dinner footprint - \(dinnerEmission) kg/co2","Footprint for other meals \(otherMealsEmission) kg/co2"]
    }

    @IBOutlet var tableForMeals: UITableView!
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return foodForMeals.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
//        view.layer.cornerRadius = 10
        
        let image = UIImageView(image: UIImage(named: images[section]))
        image.frame = CGRect (x: 5, y: 5, width: 65, height: 65)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = sections[section]
        label.frame = CGRect(x: 80, y: 5, width: 100, height: 65)
        view.addSubview(label)
        
        let widthOfView = view.frame.width
        
        
        let button = UIButton()
        
        button.tag = section
        button.setImage(UIImage(systemName: "plus"), for: [])
        button.frame = CGRect(x:0.787292817679558*self.view.frame.width, y:0.008576329331046312*self.view.frame.height,width: 60,height: 60)
//        button.backgroundColor = .green
        button.tintColor =  UIColor(red: 0.396, green: 0.769, blue: 0.4, alpha: 1)
        
        button.addTarget(self, action: #selector(btnTouched(sender:)), for: .touchUpInside)
        
       
        
        view.addSubview(button)
        
        let imageButton = UIButton()
        
        imageButton.tag = section
        imageButton.setImage(UIImage(systemName: "camera.fill"), for: [])
        imageButton.frame = CGRect(x:0.787292817679558*self.view.frame.width - 45, y:0.008576329331046312*self.view.frame.height,width: 60,height: 60)
        imageButton.tintColor =  UIColor(red: 0.396, green: 0.769, blue: 0.4, alpha: 1)
        
        view.addSubview(imageButton)
        
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if foodForMeals[section].count == 0{
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
       
        return view
    }
//
    func performSeg(){
        let myVC = foodActionVC()
        myVC.performSegue(withIdentifier: "goToFoodTable", sender: self)
    }
    
    @objc func btnTouched(sender: UIButton) {
        var buttonNumber = sender.tag
  
        if buttonNumber == 0{
            currentMeal = "breakfast"
        }
        else if buttonNumber == 1{
            currentMeal = "lunch"
        }
        else if buttonNumber == 2{
            currentMeal = "dinner"
        }
        else{
            currentMeal = "otherMeals"
        }
        shoudlSegueBePerformedForFoodTable = true
        
    }
    
    var foodAmount = 0

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
 
        foodAmount = foodForMeals[section].count
        if isSectionCollapsed[section] == true{
            return 1
        }
        else if foodAmount != 0 {
            foodAmount+=1
            return foodAmount
        }
        else{
            return foodAmount
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSectionCollapsed[indexPath.section]{
            let cell = tableView.dequeueReusableCell(withIdentifier: "collapsedSec", for: indexPath)
            cell.textLabel?.text = mealFootprint[indexPath.section]
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
        else if indexPath.row == lastRow[indexPath.section] {
            let cellForCollapse = tableView.dequeueReusableCell(withIdentifier: "collapseCell", for: indexPath)
            cellForCollapse.backgroundColor = UIColor.white
            cellForCollapse.layer.cornerRadius = 20
            cellForCollapse.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cellForCollapse.textLabel?.text = mealFootprint[indexPath.section]
            let button = UIButton()
            button.setImage(UIImage(systemName: "arrowtriangle.up"), for: [])
            button.frame = CGRect(x:0.8238950276243094*self.view.frame.width, y:0.008576329331046312*self.view.frame.height, width: 38.5, height: 38.5)

            button.tag = indexPath.section
            button.addTarget(self, action: #selector(collpaseTable(sender: )), for: .touchUpInside)
            cellForCollapse.addSubview(button)
            return cellForCollapse
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)

            cell.layer.cornerRadius = 0
            cell.layer.maskedCorners = []
            cell.backgroundColor = UIColor.white
            var cellMeal =  foodForMeals[indexPath.section][indexPath.row] as! String
            cellMeal = String(cellMeal.dropFirst(2))
            cellMeal += " \(weightForMeals[indexPath.section][indexPath.row])"

            cellMeal+=" kg"
            cell.textLabel?.text = cellMeal
            return cell
        }
    }
    
    @objc func collpaseTable(sender: UIButton){
        let meal = sender.tag
        isSectionCollapsed[meal] = true
        tableForMeals.reloadData()
    }
    @objc func uncollpaseTable(sender: UIButton){
        let meal = sender.tag
        isSectionCollapsed[meal] = false
        tableForMeals.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foodForMeals[indexPath.section].remove(at: indexPath.row)
            weightForMeals[indexPath.section].remove(at: indexPath.row)
            saveDef.set(foodForMeals, forKey: "foodForMealsArray")
            saveDef.set(weightForMeals, forKey: "wieghtForMealsArray")
            saveDef.synchronize()
            lastRow = []
            lastRow.append(foodForMeals[0].count)
            lastRow.append(foodForMeals[1].count)
            lastRow.append(foodForMeals[2].count)
            lastRow.append(foodForMeals[3].count)
            
            setAllFootprintTitles()
            tableForMeals.reloadData()

         
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
