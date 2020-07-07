//
//  NetworkService.swift
//  FourSqaureSample
//
//  Created by Ahmed on 7/8/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation
import Promises

protocol NetworkService {
    func call(endpoint: Endpoint) -> Promise<Data>
    func callModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint) -> Promise<Model>
    func uploadModel<Model: Codable>(_ model: Model.Type, endpoint: Endpoint) -> Promise<Model>
}
