//
//  AuthorizationHandler.swift
//  FourSqaureSample
//
//  Created by Ahmed on 7/8/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation

protocol AuthorizationHandler {
    var tokenHeader: [String: String] { get }

}
