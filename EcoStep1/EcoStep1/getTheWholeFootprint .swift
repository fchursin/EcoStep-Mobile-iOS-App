//
//  getTheWholeFootprint .swift
//  EcoStep1
//
//  Created by Федор on 13.02.2022.
//

import UIKit

class wholeFootprintCalculations{
        
    let foodEmmisionClass = foodEmmission()
    let transportEmissionClass = transportFootprintClass()
    let drinksEmissionClass = drinksEmission()
    // TO DO: Add Drinks,Transport,Houisng Classes
    
    func getTheWholeFootprint()->Double{
        var co2Footpint:Double = 0.0
        
        co2Footpint += foodEmmisionClass.getFootprintForAllMeals()
        co2Footpint += transportEmissionClass.getFootprintForAll(allRoutes:routeLength as! [[Double]])
        co2Footpint += drinksEmissionClass.getFootprintForDrinks()
        // TO DO: Add footprint from Drinks, Transpot, Housing
        
        return co2Footpint
    }

    
    
}
