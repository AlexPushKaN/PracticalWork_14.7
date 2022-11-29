//
//  Weather.swift
//  PracticalWork_14.7
//
//  Created by Alexandr on 27.11.2022.
//

import Foundation

struct Data:Decodable {
    
    var weather:[Weather]
    var main:[String:Double]
    var name:String
    
    enum  CodingKeys: String, CodingKey {
        case weather
        case main
        case name
    }
}

struct Weather:Decodable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}
