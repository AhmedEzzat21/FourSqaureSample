//
//  GetPlaceEndPoint.swift
//  FourSqaureSample
//
//  Created by Ahmed on 7/8/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

class GetPlaceEndPoint: Endpoint {
    var service: EndpointService = .places
    
    var url: String = ""
    
    var method: EndpointMethod = .get
    
    var auth: AuthorizationHandler = NoneAuthorizationHandler()
    
    var parameters: [String: Any] = [:]
    
    var encoding: EndpointEncoding = .query
    
    var headers: [String: String] = [:]
    init(lat: Double , lng : Double ) {
        url += "search/recommendations?ll=\(lat),\(lng)&v=20190401&radius=300&intent=venues&client_id=\(NetworkConstant.client_id)&client_secret=\(NetworkConstant.client_secret)"
         }
    
      
}
