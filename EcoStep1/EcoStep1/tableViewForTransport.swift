//
//  tableViewForTransport.swift
//  EcoStep1
//
//  Created by Федор on 22.02.2022.
//

import UIKit

var routeLength = [[],[],[],[],[]]

class tableViewControllerForTransport:UITableViewController{
    
    let imagesForTranspor = ["bus","oncoming_automobile","bullettrain_front","airplane","passenger_ship"]
    let labelsForTranspot = ["Public Transport","Car","Train","Airplane","Ship"]
    var sectionCollapsed = [false,false,false,false,false]
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let image = UIImageView()
        image.image = UIImage(named: imagesForTranspor[section])
        image.frame = CGRect (x: 5, y: 5, width: 65, height: 65)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = labelsForTranspot[section]
    
        
        label.frame = CGRect(x: 80, y: 5, width: 130, height: 65)
       
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        if routeLength[section].count == 0{
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        view.addSubview(label)
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: [])
        button.addTarget(self, action: #selector(setBoolForTransport(sender:)), for: .touchUpInside)
        button.frame = CGRect(x:0.787292817679558*self.view.frame.width, y:0.008576329331046312*self.view.frame.height,width: 60,height: 60)
        button.tag = section
        button.tintColor =  UIColor(red: 0.396, green: 0.769, blue: 0.4, alpha: 1)
        
        view.addSubview(button)
        
        return view
    }
    
    @objc func setBoolForTransport(sender:UIButton){
        let tag = sender.tag
        transportType = tag
        shouldSegueToMApBePerformed = true
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tripsAmount = routeLength[section].count
        if sectionCollapsed[section]{
            return 1
        }
        else if tripsAmount != 0{
            return tripsAmount + 1
        }
        else{
            return tripsAmount
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sectionCollapsed[indexPath.section]{
            let cell = tableView.dequeueReusableCell(withIdentifier: "collapsedSec", for: indexPath)
            cell.textLabel?.text = "Footprint for \(labelsForTranspot[indexPath.section]) trips \(String(transportFootprintClass().getFootprintForTransportType(allRoutes: routeLength[indexPath.section] as! [Double], transportType: labelsForTranspot[indexPath.section])).prefix(4)) kg/co2"
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
        else if indexPath.row == routeLength[indexPath.section].count {
            let cellForCollapse = tableView.dequeueReusableCell(withIdentifier: "collapseCell", for: indexPath)
            cellForCollapse.backgroundColor = UIColor.white
            cellForCollapse.layer.cornerRadius = 20
            cellForCollapse.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            
            
            cellForCollapse.textLabel?.text = "Footprint for trips \(String(ceil(transportFootprintClass().getFootprintForTransportType(allRoutes: routeLength[indexPath.section] as! [Double], transportType: labelsForTranspot[indexPath.section])))) kg/co2"
            let button = UIButton()
            button.setImage(UIImage(systemName: "arrowtriangle.up"), for: [])
            button.frame = CGRect(x:0.8238950276243094*self.view.frame.width, y:0.008576329331046312*self.view.frame.height, width: 38.5, height: 38.5)
            button.tag = indexPath.section
            button.addTarget(self, action: #selector(collpaseTable(sender: )), for: .touchUpInside)
            cellForCollapse.addSubview(button)
            return cellForCollapse
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "transportCell", for: indexPath)
            
            cell.layer.cornerRadius = 0
            cell.layer.maskedCorners = []
            cell.backgroundColor = UIColor.white
            var cellMeal = " \(routeLength[indexPath.section][indexPath.row])"

            cellMeal+=" km"
            cell.textLabel?.text = cellMeal
            return cell
        }
    }
    @objc func collpaseTable(sender: UIButton){
        let transportType = sender.tag
        sectionCollapsed[transportType] = true
        tableView.reloadData()
    }
    @objc func uncollpaseTable(sender: UIButton){
        let transportType = sender.tag
        sectionCollapsed[transportType] = false
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            routeLength[indexPath.section].remove(at: indexPath.row)
            saveDef.set(routeLength, forKey: "allRoutesLengthArray")
            saveDef.synchronize()
            tableView.reloadData()

         
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            
        }
    }
    
}

class transportFootprintClass{
    let emmisionPerKilometerByShip = 0.009
    let emmisionPerKilometerByPbTr = 0.064
    let emmisionPerKilometerByPlane = 0.27
    let emmisionPerKilometerByCar = 0.072
    let emmisionPerKilometerByTrain = 0.014
    
    func getFootprintForTransportType(allRoutes:[Double],transportType:String)->Double{
        var emission = 0.0
        
        let lengthOfAllRoutes = allRoutes.reduce(0, +)
        
        switch transportType{
        case "Car":
            emission += lengthOfAllRoutes * emmisionPerKilometerByCar
        case "Ship":
            emission += lengthOfAllRoutes * emmisionPerKilometerByShip
        case "Train":
            emission += lengthOfAllRoutes * emmisionPerKilometerByTrain
        case "Public Transport":
            emission += lengthOfAllRoutes * emmisionPerKilometerByPbTr
        case "Airplane":
            emission += lengthOfAllRoutes * emmisionPerKilometerByPlane
        default:
            emission = 0
        }
        return emission
    }
    
    func getFootprintForAll(allRoutes:[[Double]])->Double{
        var emission = 0.0
        
        let lengthOfPublicTransportRoutes = allRoutes[0].reduce(0, +)
        let emissionOfPublicTransport = lengthOfPublicTransportRoutes * emmisionPerKilometerByPbTr
        
        
        let lengthOfCarRoutes = allRoutes[1].reduce(0, +)
        let emissionOfCar = lengthOfCarRoutes * emmisionPerKilometerByCar
        
        let lengthOfTrainRoutes = allRoutes[2].reduce(0, +)
        let emissionOfTrain = lengthOfTrainRoutes * emmisionPerKilometerByTrain
        
        let lengthOfAirPlaneRoutes = allRoutes[3].reduce(0, +)
        let emissionOfAirPlanes = lengthOfAirPlaneRoutes * emmisionPerKilometerByPlane
        
        let lengthOfShipRoutes = allRoutes[4].reduce(0, +)
        let emissionOfShips = lengthOfShipRoutes * emmisionPerKilometerByShip
        
        emission = emissionOfPublicTransport + emissionOfCar + emissionOfTrain + emissionOfAirPlanes + emissionOfShips
        return emission
    }
}

class transportTips{
    var tipsTextArray = ["TRT Try to cycle instead of using transport for short trips.","TRT Try to walk for short trips.","TRT Try to use electric transport.","TRT It's better to use a ship for long journeys.","TRT Think about carpooling for daily trips.","TRT Walking will always be the most ecological way to get from one point to another.","TRT Try using public transport instread of a car.","TRT Try using a ship or a train instead of a plane."]
    
    
    func returnTransportTipsArray()->Array<String>{
        
        tipsTextArray = ["TRT Try to cycle instead of using transport for short trips.","TRT Try to walk for short trips.","TRT Try to use electric transport.","TRT It's better to use a ship for long journeys.","TRT Think about carpooling for daily trips.","TRT Walking will always be the most ecological way to get from one point to another.","TRT Try using public transport instread of a car.","TRT Try using a ship or a train instead of a plane."]
        
        var tipsArray:Array<String> = []
        
        let trips = routeLength
        
        var tripsCounter = 0
        
        
        for i in 0..<trips.count{
            for _ in 0..<trips[i].count{
                tripsCounter += 1
            }
        }
        
        if tripsCounter>0 && tripsCounter<2{
            tipsArray.append(tipsTextArray.randomElement()!)
        }
        else if tripsCounter>1 && tripsCounter<3{
            let firstTip = tipsTextArray.randomElement()!
            tipsTextArray.remove(at: tipsTextArray.firstIndex(of: firstTip)!)
            let secondTip = tipsTextArray.randomElement()!
            tipsArray.append(firstTip)
            tipsArray.append(secondTip)
        }
        else if tripsCounter>2{
            let firstTip = tipsTextArray.randomElement()!
            tipsTextArray.remove(at: tipsTextArray.firstIndex(of: firstTip)!)
            let secondTip = tipsTextArray.randomElement()!
            tipsTextArray.remove(at: tipsTextArray.firstIndex(of: secondTip)!)
            let thirdTip = tipsTextArray.randomElement()!
            tipsArray.append(firstTip)
            tipsArray.append(secondTip)
            tipsArray.append(thirdTip)
        }
        
        return tipsArray
    }
    
    
}
