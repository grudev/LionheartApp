//
//  ResponseData.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 15.02.21.
//

import Foundation

struct ResponseData<T>: Codable where T: Codable {
    var data: T
    var success: Bool
    var status: Int
}
