//
//  GetPlacesView.swift
//  FourSqaureSample
//
//  Created by Ahmed on 7/8/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import CoreLocation

class GetPlacesView: BaseView<GetPlacesPresenter, BaseItem> ,CLLocationManagerDelegate{
    var firstLanche = true
    var currentLocation:CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    @IBOutlet weak var placesCollection: UICollectionView! {
        didSet {
            self.placesCollection.register(UINib(nibName: String(describing: PlacesCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PlacesCollectionViewCell.self))
            
             self.placesCollection.register(UINib(nibName: String(describing: NoDataFoundCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: NoDataFoundCollectionViewCell.self))
            //NoDataFoundCollectionViewCell
        }
    }
    
    override func bindind() {
        presenter = GetPlacesPresenter(router: RouterManager(self), userRepo: UserRepoImpl())

            self.locationManager.requestAlwaysAuthorization()
            
            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                
                locationManager.distanceFilter = 500 // distance changes you want to be informed about (in meters)
                locationManager.desiredAccuracy = 100 // biggest approximation you tolerate (in meters)
                locationManager.activityType = .automotiveNavigation // .automotiveNavigation will stop the updates when the device is not moving


            }
       
       self.placesCollection.reloadData()

      
    }
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
      
      guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
      self.currentLocation = locValue
      
      if firstLanche{
          updatLocation()
      }
      
      
      
  }
    func updatLocation(){
           
           
        
            presenter.getPlaces(lat: currentLocation!.latitude, lng: currentLocation!.longitude)
          presenter.places.bind { _ in
                             self.placesCollection.reloadData()
                         }
           firstLanche = false
           
           
           
           
       }
    
}
extension GetPlacesView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.places.value.isEmpty {
              return 1
        }
        else{
            
           return presenter.places.value.count
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if presenter.places.value.isEmpty {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NoDataFoundCollectionViewCell.self), for: indexPath))  as! NoDataFoundCollectionViewCell
                       
              return cell
        }else {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlacesCollectionViewCell.self), for: indexPath))  as! PlacesCollectionViewCell
            cell.configure(result: presenter.places.value[indexPath.row], index: indexPath.row)
              return cell
        }
        
            
    }
    
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  presenter.places.value.isEmpty {
             return CGSize( width: (collectionView.frame.width), height:collectionView.frame.height )
        }
        else {
             return CGSize( width: (collectionView.frame.width), height: 120 )
        }
       
    }
    
}


