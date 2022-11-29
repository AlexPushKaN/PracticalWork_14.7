//
//  Persistance.swift
//  PracticalWork_14.7
//
//  Created by Alexandr on 23.11.2022.
//

import Foundation

class Persistance {
    
    static let shared = Persistance()
    
    private var kUserNameKey = "Persistance.kUserNameKey"
    private var kUserSecondNameKey = "Persistance.kUserSecondNameKey"
    
    var userName:String? {
        set {UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get {UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    
    var userSecondName:String? {
        set {UserDefaults.standard.set(newValue, forKey: kUserSecondNameKey)}
        get {UserDefaults.standard.string(forKey: kUserSecondNameKey)}
    }
}
