//
//  Database.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Foundation

class Database{
    static let storedDataUserDefaultsKey = "storedDataUserDefaultsKey"

    static func save(dictionary: [String: Any]){

        UserDefaults.standard.set(dictionary, forKey: storedDataUserDefaultsKey)
        UserDefaults.standard.synchronize()
    }
    
    static func loadDictionary() -> [String: Any]?{
        UserDefaults.standard.dictionary(forKey: storedDataUserDefaultsKey)
    }

}
