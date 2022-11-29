//
//  WeatherItem.swift
//  PracticalWork_14.7
//
//  Created by Alexandr on 28.11.2022.
//

import Foundation
import RealmSwift

class WeatherItem:Object {
    @objc dynamic var iconWeather:String = ""
    @objc dynamic var mainTemp:String = ""
    @objc dynamic var nameSity:String = ""
}
