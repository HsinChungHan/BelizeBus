//
//  MapViewController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/5/23.
//  Copyright © 2018年 辛忠翰. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    let busStations = BusStation.getBusStations()
    let locationManager = CLLocationManager()
    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.showsCompass = true
        mv.showsScale = true
        mv.showsTraffic = true
        mv.showsUserLocation = true
        return mv
    }()
    
    lazy var currentLocationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "ninja").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(fetchCurrentLocation), for: .touchUpInside)
        return btn
    }()
    
    lazy var nearByBusLocationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "ginger").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(fetchCurrentBusLocation), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setupViews()
        setupAnnotation(busStations: busStations)
        authorizedUserLocation()
    }
}


extension MapViewController{
    
    internal func setupViews(){
        view.addSubview(mapView)
        mapView.fullAnchor(superView: view)
        view.addSubview(currentLocationButton)
        currentLocationButton.anchor(top: view.topAnchor, bottom: nil, left: nil, right: view.rightAnchor, topPadding: 50, bottomPadding: 0, leftPadding: 0, rightPadding: 20, width: 40, height: 40)
        view.addSubview(nearByBusLocationButton)
        nearByBusLocationButton.anchor(top: currentLocationButton.bottomAnchor, bottom: nil, left: nil, right: currentLocationButton.rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 40, height: 40)
    }
    
    internal func authorizedUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse{
            mapView.showsUserLocation = true
        }
    }
    
    internal func setupAnnotation(busStations: [BusStation]){
        for station in busStations{
            createPlaceMark(busStation: station)
        }
        
    }
    
    internal func createPlaceMark(busStation: BusStation){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: busStation.latitude , longitude: busStation.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if let error = error{
                print("Failed to reverse address from location, ", error)
                return
            }
            guard let placeMarks = placeMarks else {
                print("PlaceMarks is nil")
                return
            }
            
            var address = ""
            if let country = placeMarks[0].country {//国家
                address.append("\(country), ")
            }
            if let administrativeArea = placeMarks[0].administrativeArea {//省份
                address.append("\(administrativeArea), ")
            }
            if let subAdministrativeArea = placeMarks[0].subAdministrativeArea {//其他行政区域信息（自治区等）
                address.append("\(subAdministrativeArea), ")
            }
            if let locality = placeMarks[0].locality {//城市
                address.append("\(locality), ")
            }
            if let subLocality = placeMarks[0].subLocality {//區劃
                address.append("\(subLocality), ")
            }
            if let thoroughfare = placeMarks[0].thoroughfare {//街道
                address.append("\(thoroughfare), ")
            }
            if let subThoroughfare = placeMarks[0].subThoroughfare {//門牌：
                address.append("\(subThoroughfare), ")
            }
            if let name = placeMarks[0].name {//地名
                address.append("\(name), ")
            }
            if let isoCountryCode = placeMarks[0].isoCountryCode {//國家編碼
                address.append("\(isoCountryCode), ")
            }
            if let postalCode = placeMarks[0].postalCode {//郵編
                address.append("\(postalCode), ")
            }
            if let areasOfInterest = placeMarks[0].areasOfInterest {//关联的或利益相关的地标
                address.append("\(areasOfInterest), ")
            }
            if let ocean = placeMarks[0].ocean {//海洋
                address.append("\(ocean), ")
            }
            if let inlandWater = placeMarks[0].inlandWater {//水源，湖泊
                address.append("\(inlandWater)")
            }
            print("Address: ", address)
            
            if let location = placeMarks[0].location {
                let annotation = MKPointAnnotation()
                annotation.title = busStation.name
                annotation.subtitle = address
                annotation.coordinate = location.coordinate
                
                // Display the annotation
                self.mapView.showAnnotations([annotation], animated: true)
//                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }
    
    
    @objc func fetchCurrentLocation(){
        let span = MKCoordinateSpanMake(0.8, 0.8)
        let region = MKCoordinateRegionMake(mapView.userLocation.coordinate, span)
        mapView.setRegion(region, animated: true)
        print("Press current")
    }
    
    
    
    @objc func fetchCurrentBusLocation(){
        let searchRequest = MKLocalSearchRequest()
        searchRequest.region = mapView.region
        
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { (response, error) in
            if let error = error{
                print("Failed to fetch current bus station!", error)
                return
            }
            guard let response = response else {return}
            let mapItems = response.mapItems
            var currentBusStations = [MKAnnotation]()
            for item in mapItems{
                let annotation = MKPointAnnotation()
                annotation.title = item.name
                annotation.subtitle = "I am near by u!!"
                currentBusStations.append(annotation)
            }
            self.mapView.showAnnotations(currentBusStations, animated: true)
        }
        
    }
}
