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
        return presenter.places.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlacesCollectionViewCell.self), for: indexPath))  as! PlacesCollectionViewCell
        cell.configure(result: presenter.places.value[indexPath.row], index: indexPath.row)
        
        return cell
        
    }
    
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize( width: (collectionView.frame.width), height: 120 )
    }
    
}


