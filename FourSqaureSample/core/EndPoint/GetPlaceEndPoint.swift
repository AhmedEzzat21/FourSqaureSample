//
//  GetPlaceEndPoint.swift
//  FourSqaureSample
//
//  Created by Ahmed on 7/8/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

class ShowPlacesEndPoint: Endpoint {
    var service: EndpointService = .places
    
    var url: String = ""
    
    var method: EndpointMethod = .get
    
    var auth: AuthorizationHandler = NoneAuthorizationHandler()
    
    var parameters: [String: Any] = [:]
    
    var encoding: EndpointEncoding = .query
    
    var headers: [String: String] = [:]
    init(meetingID: Int) {
          url += "/\(meetingID))"
         }
      
}
