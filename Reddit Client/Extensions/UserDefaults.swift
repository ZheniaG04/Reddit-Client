//
//  UserDefaults.swift
//  Reddit Client
//
//  Created by Женя on 30.05.2021.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let wasLocalDataLoaded = "wasLocalDataLoaded"
    }
    
    var wasLocalDataLoaded: Bool {
        get {
            bool(forKey: Keys.wasLocalDataLoaded)
        }
        set {
            set(newValue, forKey: Keys.wasLocalDataLoaded)
        }
    }
}
