//
//  actionsPageVC.swift
//  EcoStep1
//
//  Created by Федор on 30.12.2021.
//

import UIKit

var currentPage = ""

var onBoardPage = ""

class actionsVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    var timer = Timer()
    
    override func viewWillAppear(_ animated: Bool) {
        
        onBoardPage = "actions"
        
        dataSource = self
        delegate = self
        
        if saveDef.bool(forKey: "actionsFirstLaunch") == false{
            performSegue(withIdentifier: "actionsOnBoard", sender: self)
        }
        

        if currentPage == ""{
            orderedViewControllers = orderedViewControllersFood
        }
        else if currentPage == "drinks"{
            orderedViewControllers = orderdViewControllersDrinks
        }
        else if currentPage == "food"{
            orderedViewControllers = orderedViewControllersFood
        }
        else if currentPage == "transport"{
            orderedViewControllers = orderedViewControllersTransportation
        }
        
        
        if let firstViewController = orderedViewControllers.first {
                setViewControllers([firstViewController],
                    direction: .forward,
                    animated: false,
                    completion: nil)
            }
    }
    
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of:viewController) else {
                    return nil
                }
                
                let previousIndex = viewControllerIndex - 1
                
                // User is on the first view controller and swiped left to loop to
                // the last view controller.
                guard previousIndex >= 0 else {
                    return orderedViewControllers.last
                }
                
                guard orderedViewControllers.count > previousIndex else {
                    return nil
                }
                
                return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
                    return nil
                }
                
                let nextIndex = viewControllerIndex + 1
                let orderedViewControllersCount = orderedViewControllers.count
                
                // User is on the last view controller and swiped right to loop to
                // the first view controller.
                guard orderedViewControllersCount != nextIndex else {
                    return orderedViewControllers.first
                }
                
                guard orderedViewControllersCount > nextIndex else {
                    return nil
                }
                
                return orderedViewControllers[nextIndex]
        
        
    }
    
    private(set) lazy var orderdViewControllersDrinks:[UIViewController] = {
        return [self.newActionViewController(action: "drinksActionVC"),
            self.newActionViewController(action: "transportationActionVC"),
            self.newActionViewController(action: "foodActionVC")]
    }()
    
    private(set) lazy var orderedViewControllersTransportation: [UIViewController] = {
        return [self.newActionViewController(action: "transportationActionVC"),
            self.newActionViewController(action: "foodActionVC"),
                self.newActionViewController(action: "drinksActionVC")]
    }()
    
    private(set) lazy var orderedViewControllersHousing: [UIViewController] = {
        return [self.newActionViewController(action: "foodActionVC"),
                self.newActionViewController(action: "drinksActionVC"),
                self.newActionViewController(action: "transportationActionVC")]
    }()
    
    private(set) lazy var orderedViewControllersFood: [UIViewController] = {
        return [self.newActionViewController(action: "foodActionVC"),
            self.newActionViewController(action: "drinksActionVC"),
            self.newActionViewController(action: "transportationActionVC")]
    }()
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newActionViewController(action: "foodActionVC"),
            self.newActionViewController(action: "drinksActionVC"),
            self.newActionViewController(action: "transportationActionVC")]
    }()
    private func newActionViewController(action: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
        instantiateViewController(withIdentifier: "\(action)")
    }
}
