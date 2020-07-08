//
//  GetPlacesView.swift
//  FourSqaureSample
//
//  Created by Ahmed on 7/8/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class GetPlacesView: BaseView<GetPlacesPresenter, BaseItem> {
    
    @IBOutlet weak var placesCollection: UICollectionView! {
        didSet {
            self.placesCollection.register(UINib(nibName: String(describing: PlacesCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PlacesCollectionViewCell.self))
        }
    }
    
    override func bindind() {
        presenter = GetPlacesPresenter(router: RouterManager(self), userRepo: UserRepoImpl())
//        presenter.delegate = item.countryDelegate
//        presenter.userCountry.value = item.userCountry
        presenter.places.bind { _ in
            self.placesCollection.reloadData()
        }
        presenter.getPlaces()
       
      
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
        return CGSize( width: (collectionView.frame.width), height: 36 )
    }
    
}


