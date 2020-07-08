//
//  GetPlacesPresenter.swift
//  FourSqaureSample
//
//  Created by Ahmed on 7/8/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation
import Bond
class GetPlacesPresenter:BasePresenter {
    
    var router: RouterManagerProtocol
  
    var userRepo: UserRepo
    var lat: Observable<Double?> = Observable(0.0)
    var lng: Observable<Double?> = Observable(0.0)
    var places: Dynamic<[Result]> = Dynamic([])

    init(router: RouterManagerProtocol, userRepo: UserRepo ) {
        self.router = router
        self.userRepo = userRepo
      
        
    }
    
    
    
    override func hydrate() {
        
        
    }
    func meetingDetails() {
        showLoading()
        GetPlacesProcessor(userRepo: userRepo, lat: lat.value ?? 0.0, lng: lng.value ?? 0.0).execute()
            .then { (response) in
                
                self.hideLoading()
                self.places.value = response.response?.group?.results ?? []

                
        }.catch { (error) in
            self.hideLoading()
            self.showSystemError(error: error)}
    }
    func back() {
        router.dismiss()
    }
    
    
}

