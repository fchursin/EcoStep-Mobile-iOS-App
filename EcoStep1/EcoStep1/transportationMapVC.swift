//
//  transportationMapVC.swift
//  EcoStep1
//
//  Created by Федор on 22.01.2022.
//

import UIKit
import MapKit
import CoreLocation

var transportType = -1

class transoportationMapVC: UIViewController{
    
    var currentTravelDistance = 0.0
    
    func setArraysForTransport(){
        
        routeLength = (saveDef.array(forKey: "allRoutesLengthArray") ?? [[],[],[],[],[]]) as! Array<Array<Any>>
        
    }
    
    
    func drawStraightLine(coordinates:[CLLocationCoordinate2D], nameOfDestination:String,nameOfStartPoint:String,orderOfCoordinates:[String]){
        var coordinateFrom:CLLocationCoordinate2D
        var coordinateTo:CLLocationCoordinate2D
        
        if orderOfCoordinates[0] == "to"{
            coordinateTo = coordinates[0]
            coordinateFrom = coordinates[1]
        }
        else{
            coordinateTo = coordinates[1]
            coordinateFrom = coordinates[0]
        }
        
        let locTo = CLLocation(latitude: coordinateTo.latitude, longitude: coordinateTo.longitude)
        let locFrom = CLLocation(latitude: coordinateFrom.latitude, longitude: coordinateFrom.longitude)
        
        let distanceBetween = Int(locTo.distance(from: locFrom)/1000)
        
        routeLenghtLabel.text = "Route length is \(distanceBetween) km"
        
        currentTravelDistance = Double(distanceBetween)
        
        var coordinates_1 = [coordinateTo, coordinateFrom]
        
        let myPolyLine_1: MKPolyline = MKPolyline(coordinates: &coordinates_1, count: coordinates_1.count)
        let annotationFrom = MKPointAnnotation()
        annotationFrom.title = nameOfStartPoint
        annotationFrom.coordinate = coordinateFrom
        
        let annotationTo = MKPointAnnotation()
        annotationTo.title = nameOfDestination
        annotationTo.coordinate = coordinateTo
        
        
        
        mapView.addAnnotation(annotationFrom)
        mapView.addAnnotation(annotationTo)
        
        mapView.addOverlay(myPolyLine_1)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var routeLenghtLabel: UILabel!
    @IBOutlet weak var searchControllerFrom: UISearchBar!
    @IBOutlet weak var searchControllerTo: UISearchBar!
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var addTripBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var getRouteBtn: UIButton!
    
    @IBOutlet weak var labelTo: UILabel!
    @IBOutlet weak var labelFrom: UILabel!
    
    @IBOutlet weak var locationBtn: UIButton!
    
    @IBOutlet weak var changeBtn: UIButton!
    var coordinatesFromAndTo:[CLLocationCoordinate2D] = []
    var stringFromCoord = ""
    var stringToCoord = ""
    var orderOfCoordinates:[String] = []
    
    
    let locationManager = CLLocationManager()
    let regionInMetres = 10000.0
    
    var isTypingTo = false
    var isTypingFrom = false
    var isBothTyping = false
    
    var directionsArray: [MKDirections] = []
    
    var locationsToArray:[CLLocationCoordinate2D] = []
    var locationToString = ""
    
    var locationFromArray:[CLLocationCoordinate2D] = []
    var locationFromString = ""
    
    var previousLocation:CLLocation?
    
    func layoutAllViews(){
        pinImage.frame = CGRect(x:self.view.frame.midX-20, y:self.view.frame.midY-20,width: 40,height: 40)
        locationBtn.frame = CGRect(x:0.007246376811594203*self.view.frame.width, y:0.7924107142857143*self.view.frame.height,width: 40,height: 40)
        getRouteBtn.frame = CGRect(x:self.view.frame.width-70, y:0.7700892857142857*self.view.frame.height,width: 70,height: 70)
        mapView.frame = CGRect(x:0.004830917874396135*self.view.frame.width, y:0.15066964285714285*self.view.frame.height, width:0.9903381642512077*self.view.frame.width,height:0.7377232142857143*self.view.frame.height)
        adressLabel.frame = CGRect(x:0.0*self.view.frame.width, y:0.8459821428571429*self.view.frame.height, width:1.0*self.view.frame.width,height:0.05580357142857143*self.view.frame.height)
        adressLabel.adjustsFontSizeToFitWidth = true
        adressLabel.minimumScaleFactor = 0.1
        adressLabel.numberOfLines = 0
        adressLabel.lineBreakMode = .byClipping
        routeLenghtLabel.frame = CGRect(x:0.0*self.view.frame.width, y:0.78125*self.view.frame.height, width:1.0*self.view.frame.width,height:0.05580357142857143*self.view.frame.height)
        routeLenghtLabel.adjustsFontSizeToFitWidth = true
        routeLenghtLabel.minimumScaleFactor = 0.1
        routeLenghtLabel.numberOfLines = 0
        routeLenghtLabel.lineBreakMode = .byClipping
        searchControllerFrom.frame = CGRect(x:0.10869565217391304*self.view.frame.width, y:0.08147321428571429*self.view.frame.height, width:0.8792270531400966*self.view.frame.width,height:0.0625*self.view.frame.height)
        searchControllerTo.frame = CGRect(x:0.10869565217391304*self.view.frame.width, y:0.033482142857142856*self.view.frame.height, width:0.8792270531400966*self.view.frame.width,height:0.0625*self.view.frame.height)
        addTripBtn.frame = CGRect(x:0.35990338164251207*self.view.frame.width, y:0.9129464285714286*self.view.frame.height, width:0.2898550724637681*self.view.frame.width,height:0.044642857142857144*self.view.frame.height)
        backBtn.frame = CGRect(x:0.007246376811594203*self.view.frame.width, y:0.9129464285714286*self.view.frame.height, width:0.28019323671497587*self.view.frame.width,height:0.044642857142857144*self.view.frame.height)
        labelTo.frame = CGRect(x:0.007246376811594203*self.view.frame.width, y:0.049107142857142856*self.view.frame.height, width:0.05555555555555555*self.view.frame.width,height:0.0234375*self.view.frame.height)
        labelTo.adjustsFontSizeToFitWidth = true
        labelTo.minimumScaleFactor = 0.1
        labelTo.numberOfLines = 0
        labelTo.lineBreakMode = .byClipping
        labelFrom.frame = CGRect(x:0.007246376811594203*self.view.frame.width, y:0.09821428571428571*self.view.frame.height, width:0.10628019323671498*self.view.frame.width,height:0.0234375*self.view.frame.height)
        labelFrom.adjustsFontSizeToFitWidth = true
        labelFrom.minimumScaleFactor = 0.1
        labelFrom.numberOfLines = 0
        labelFrom.lineBreakMode = .byClipping
        changeBtn.frame = CGRect(x:0.7077294685990339*self.view.frame.width, y:0.9129464285714286*self.view.frame.height, width:0.28019323671497587*self.view.frame.width,height:0.044642857142857144*self.view.frame.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layoutAllViews()
        
        allActions = saveDef.stringArray(forKey: "allActions") ?? []
        setArraysForTransport()
        coordinatesFromAndTo = []
        orderOfCoordinates = []
        stringFromCoord = ""
        stringToCoord = ""
        if shouldMapBeRestricted(){
            pinImage.isHidden = true
        }
       checkLocationServices()
        mapView.delegate = self
        searchControllerTo.delegate = self
        searchControllerFrom.delegate = self
        searchControllerTo.tag = 1
        searchControllerFrom.tag = 0
        
    }
    
    func shouldMapBeRestricted()->Bool{
        if transportType > 2 {
            return true
        }
        else{
            return false
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTripBtnPressed(_ sender: UIButton) {
        routeLength[transportType].append(currentTravelDistance)
        saveDef.set(routeLength, forKey: "allRoutesLengthArray")
        saveDef.synchronize()
        
        switch transportType{
        case 0:
            allActions.append("Pub")
        case 1:
            allActions.append("Car")
        case 2:
            allActions.append("Train")
        case 3:
            allActions.append("Plane")
        case 4:
            allActions.append("Ship")
        default:
            print("error")
        }
        saveDef.set(allActions, forKey: "allActions")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeTransport(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMetres, longitudinalMeters: regionInMetres)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            startTrackingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
      
        @unknown default:
            fatalError()
        }
    }
    
    func startTrackingLocation(){
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
 
    
    func getDirection(){
        guard let location = locationManager.location?.coordinate else{
            
            return
        }
        
        
        if shouldMapBeRestricted() == false{
            
            if locationsToArray.count <= 0 && locationFromArray.count <= 0{
                isTypingTo = false
                isTypingFrom = false
            }
            else if locationsToArray.count > 0 && locationFromArray.count <= 0{
                isTypingFrom = false
            }
            else if locationsToArray.count <= 0 && locationFromArray.count > 0{
                isTypingTo = false
            }
            
            if isTypingTo == false && isBothTyping == false && isTypingFrom == false{
                
            
                let request = createDirectionRequest(from: location)
                let directions = MKDirections(request: request)
                resetMap(withNew: directions)

                directions.calculate { [unowned self] (response,error) in

                    guard let response = response else {return}

                    for route in response.routes {
        //                print("This is the route distance \(route.distance/1000)")
                        self.mapView.addOverlay(route.polyline)
                        self.mapView.setRegion(MKCoordinateRegion(center: route.polyline.coordinate, latitudinalMeters: route.distance*0.75, longitudinalMeters: route.distance*0.75), animated: true)

                        let routeAnnotation = MKPointAnnotation()

                        routeAnnotation.coordinate = getCenterLocation(for: self.mapView).coordinate

                        let routeLengthInMeters = route.distance
                        let routeLengthInKiloMeters = Int(route.distance/1000)
                       

                        currentTravelDistance = Double(routeLengthInKiloMeters)
                        routeLenghtLabel.text = "Route lenght is \(routeLengthInKiloMeters) km"


                        self.mapView.addAnnotation(routeAnnotation)
                    }

                }
            }
            else if isTypingTo == true && isTypingFrom == false && isBothTyping == false && locationsToArray.count > 0 {
                let request = createDirectionRequestFromUsLocTo(from: location,to: locationsToArray[0])
                let directions = MKDirections(request: request)
                resetMap(withNew: directions)
                
                directions.calculate { [unowned self] (response,error) in
                    
                    guard let response = response else {return}
                    
                    for route in response.routes {
                        self.mapView.addOverlay(route.polyline)
                        self.mapView.setRegion(MKCoordinateRegion(center: route.polyline.coordinate, latitudinalMeters: route.distance*0.75, longitudinalMeters: route.distance*0.75), animated: true)
                        
                        let routeAnnotation = MKPointAnnotation()
                       
                        routeAnnotation.coordinate = locationsToArray[0]
                        routeAnnotation.title = locationToString
                        
                        let routeLengthInMeters = route.distance
                        let routeLengthInKiloMeters = Int(route.distance/1000)
                        var routeLengthFinal = Double(routeLengthInKiloMeters)
                        
                        if routeLengthInMeters/1000 - Double(routeLengthInKiloMeters) > 0.5{
                            routeLengthFinal += 0.5
                        }
                        
                        currentTravelDistance = Double(routeLengthInKiloMeters)
                        routeLenghtLabel.text = "Route lenght is \(routeLengthInKiloMeters) km"
                        
                        self.mapView.addAnnotation(routeAnnotation)
                      
                    }
                    
                }
            }
            else if isTypingTo == false && isTypingFrom == true && isBothTyping == false && locationFromArray.count > 0{
                let request = createDirectionRequestFromToUserLocation(from: locationFromArray[0], to: location)
                let directions = MKDirections(request: request)
                resetMap(withNew: directions)
                
                directions.calculate { [unowned self] (response,error) in
                    
                    guard let response = response else {return}
                    
                    for route in response.routes {
                        self.mapView.addOverlay(route.polyline)
                        self.mapView.setRegion(MKCoordinateRegion(center: route.polyline.coordinate, latitudinalMeters: route.distance*0.75, longitudinalMeters: route.distance*0.75), animated: true)
                        let routeAnnotation = MKPointAnnotation()
                       
                        routeAnnotation.coordinate = locationFromArray[0]
                        routeAnnotation.title = locationToString
                        
                        let routeLengthInMeters = route.distance
                        let routeLengthInKiloMeters = Int(route.distance/1000)
                        var routeLengthFinal = Double(routeLengthInKiloMeters)
                        
                        if routeLengthInMeters/1000 - Double(routeLengthInKiloMeters) > 0.5{
                            routeLengthFinal += 0.5
                        }
                        
                        currentTravelDistance = Double(routeLengthInKiloMeters)
                        routeLenghtLabel.text = "Route lenght is \(routeLengthInKiloMeters) km"
                        
                        self.mapView.addAnnotation(routeAnnotation)
                       
                    }
                    
                }
            }
            else if isBothTyping == true && locationsToArray.count > 0 && locationFromArray.count > 0{
                let request = createDirectionBothFromAndToLoc(from: locationFromArray[0], to: locationsToArray[0])
                let directions = MKDirections(request: request)
                resetMap(withNew: directions)
                
                directions.calculate { [unowned self] (response,error) in
                    
                    guard let response = response else {return}
                    
                    for route in response.routes {
                        self.mapView.addOverlay(route.polyline)
                        self.mapView.setRegion(MKCoordinateRegion(center: route.polyline.coordinate, latitudinalMeters: route.distance*0.75, longitudinalMeters: route.distance*0.75), animated: true)
                        
                        let routeAnnotationFrom = MKPointAnnotation()
                       
                        routeAnnotationFrom.coordinate = locationFromArray[0]
                        routeAnnotationFrom.title = locationFromString
                        
                        let routeAnnotationTo = MKPointAnnotation()
                        routeAnnotationTo.coordinate = locationsToArray[0]
                        routeAnnotationTo.title = locationToString
                        
                        let routeLengthInMeters = route.distance
                        let routeLengthInKiloMeters = Int(route.distance/1000)
                        var routeLengthFinal = Double(routeLengthInKiloMeters)
                        
                        if routeLengthInMeters/1000 - Double(routeLengthInKiloMeters) > 0.5{
                            routeLengthFinal += 0.5
                        }
                        
                        currentTravelDistance = Double(routeLengthInKiloMeters)
                        routeLenghtLabel.text = "Route lenght is \(routeLengthInKiloMeters) km"
                        
                        self.mapView.addAnnotation(routeAnnotationFrom)
                        self.mapView.addAnnotation(routeAnnotationTo)
                       
                    }
                    
                }
            }
        }
        else{
            drawStraightLine(coordinates: coordinatesFromAndTo, nameOfDestination: stringToCoord, nameOfStartPoint: stringFromCoord, orderOfCoordinates: orderOfCoordinates)
        }
    }
    
    func createDirectionBothFromAndToLoc(from startingLocation:CLLocationCoordinate2D,to endLocation:CLLocationCoordinate2D)->MKDirections.Request{
        let destinationCoordinate = MKPlacemark(coordinate: endLocation)
        let startCoordinate = MKPlacemark(coordinate: startingLocation)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startCoordinate)
        request.destination = MKMapItem(placemark: destinationCoordinate)
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        return request
    }
    
    func createDirectionRequestFromUsLocTo(from userLocation:CLLocationCoordinate2D, to endLocation:CLLocationCoordinate2D)->MKDirections.Request{
        let destinationCoordinate = MKPlacemark(coordinate: endLocation)
        let startCoordinate = MKPlacemark(coordinate: userLocation)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startCoordinate)
        request.destination = MKMapItem(placemark: destinationCoordinate)
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        return request
    }
    
    func createDirectionRequestFromToUserLocation(from startingLocation:CLLocationCoordinate2D,to userLocation:CLLocationCoordinate2D)->MKDirections.Request{
        
        let destinationCoordinate = MKPlacemark(coordinate: userLocation)
        let startCoordinate = MKPlacemark(coordinate: startingLocation)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startCoordinate)
        request.destination = MKMapItem(placemark: destinationCoordinate)
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        return request
        
    }
    
    func createDirectionRequest(from coordinate:CLLocationCoordinate2D)->MKDirections.Request{
        let destinationCoordinate = getCenterLocation(for: mapView).coordinate
        let startingLocation = MKPlacemark(coordinate: coordinate)
        
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .any
        request.requestsAlternateRoutes = false
        
        
        
        return request
    }
    
    func resetMap(withNew directions: MKDirections){
        mapView.removeOverlays(mapView.overlays)
//        directionsArray.remove(at: 0)
        let _ = directionsArray.map{$0.cancel()}
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        directionsArray.append(directions)
        
        
    }
    
    @IBAction func goButtonClicked(_ sender: UIButton) {
        getDirection()

    }
    
    
    @IBAction func navigationButtonClicked(_ sender: UIButton) {
        mapView.userTrackingMode = .follow
    }
    
    func getCenterLocation(for mapView:MKMapView) -> CLLocation{
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    

}

extension transoportationMapVC:CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationServices()
    }
}

extension transoportationMapVC:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else {return}
        
        guard center.distance(from: previousLocation) > 50 else{return}
        self.previousLocation = center
        
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else{return}
            
            if let _ = error{
                return
            }
            
            guard let placemark = placemarks?.first else{
                return
            }
            let streetName = placemark.thoroughfare ?? ""
            let houseNumber = placemark.subThoroughfare ?? ""
            
            DispatchQueue.main.async {
    
                self.adressLabel.text = "\(streetName) \(houseNumber)"
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = UIColor(red: 0.043, green:  0.561, blue:  1.000, alpha: 1)
        
        return renderer
    }
    
}

extension transoportationMapVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        searchBar.resignFirstResponder()
                if self.shouldMapBeRestricted() == false{
                        if searchBar.tag == 1{
                            self.view.endEditing(true)
                  
                            self.isTypingTo = false
                            self.locationsToArray = []
                            self.locationToString = ""
                            self.isBothTyping = false
                            
                        }
                        else if searchBar.tag == 0{
                            self.view.endEditing(true)
                            self.isTypingFrom = false
                            self.locationFromArray = []
                            self.locationFromString = ""
                            self.isBothTyping = false
                        }
                    }
                else{
                    self.mapView.removeOverlays(self.mapView.overlays)
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    self.searchControllerFrom.text = ""
                    self.searchControllerTo.text = ""
                    self.coordinatesFromAndTo = []
                    self.stringFromCoord = ""
                    self.stringToCoord = ""
                    self.orderOfCoordinates = []
    
                }
                }
        }
    }
  
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if shouldMapBeRestricted() == false{
        if searchBar.tag == 1{
            isTypingTo = true
            locationsToArray = []
            locationToString = ""
        }
        else if searchBar.tag == 0{
            isTypingFrom = true
            locationFromArray = []
            locationFromString = ""
        }
        if isTypingTo && isTypingFrom{
            isBothTyping = true
        }
        searchBar.resignFirstResponder()

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            if response == nil{
                print("Error")
            }
            else{
                
                let longitude = response?.boundingRegion.center.longitude
                let latitude = response?.boundingRegion.center.latitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                
                if searchBar.tag == 1 {
                    self.locationsToArray.append(annotation.coordinate)
                    self.locationToString = searchBar.text ?? ""
                }
                else if searchBar.tag == 0{
                    self.locationFromArray.append(annotation.coordinate)
                    self.locationFromString = searchBar.text ?? ""
                }
                
                let c1 = CLLocation(latitude: latitude!, longitude: longitude!)
                let c2:CLLocation
                let locationS:CLLocationCoordinate2D
                if let location = self.locationManager.location?.coordinate{
                    c2 = CLLocation(latitude: location.latitude, longitude: location.longitude)
                    locationS = CLLocationCoordinate2D(latitude: (latitude!+location.latitude)*0.5, longitude: (longitude!+location.longitude)*0.5)
                }
                else{
                    return
                }

                let zoom = c1.distance(from: c2)

                let region = MKCoordinateRegion(center: locationS, latitudinalMeters: zoom, longitudinalMeters: zoom)

                self.mapView.addAnnotation(annotation)
                self.mapView.setRegion(region, animated: true)
                }
            }
        }
        else{
            searchBar.resignFirstResponder()

            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = searchBar.text
            let activeSearch = MKLocalSearch(request: searchRequest)
            activeSearch.start { (response, error) in
                if response == nil{
                    print("Error")
                }
                else{
                    
                    let longitude = response?.boundingRegion.center.longitude
                    let latitude = response?.boundingRegion.center.latitude
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = searchBar.text
                    annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                    
                    if searchBar.tag == 1 {
                        self.coordinatesFromAndTo.append(annotation.coordinate)
                        self.stringToCoord = searchBar.text ?? ""
                        self.orderOfCoordinates.append("to")
                    }
                    else if searchBar.tag == 0{
                        self.coordinatesFromAndTo.append(annotation.coordinate)
                        self.stringFromCoord = searchBar.text ?? ""
                        self.orderOfCoordinates.append("from")
                    }
                    
                    let c1 = CLLocation(latitude: latitude!, longitude: longitude!)
                    let c2:CLLocation
                    let locationS:CLLocationCoordinate2D
                    if let location = self.locationManager.location?.coordinate{
                        c2 = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        locationS = CLLocationCoordinate2D(latitude: (latitude!+location.latitude)*0.5, longitude: (longitude!+location.longitude)*0.5)
                    }
                    else{
                        return
                    }

                    let zoom = c1.distance(from: c2)
                    let region = MKCoordinateRegion(center: locationS, latitudinalMeters: zoom, longitudinalMeters: zoom)
                    self.mapView.addAnnotation(annotation)
                    self.mapView.setRegion(region, animated: true)
                    }
                }
        }
    }
}
       




