//
//  Details.swift
//  IP Details
//
//  Created by Preetam Beeravelli on 9/10/22.
//

import Foundation

struct Details: Codable{
    var ip: String?
    var city: String?
    var region: String?
    var country: String?
    var loc: String?
    var postal: String?
    var timezone: String?
    //var error: ErrorStatus
}
//struct ErrorStatus: Codable{
//    var title: String?
//    var message: String?
//}
