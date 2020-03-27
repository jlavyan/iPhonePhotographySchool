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
    
    static func saveVideoPath(id: String, path: String){
        UserDefaults.standard.set(path, forKey: id)
        UserDefaults.standard.synchronize()
    }

    static func loadVideoPath(id: String) -> String?{
        return UserDefaults.standard.string(forKey: id)
    }

    
    static func loadDictionary() -> [String: Any]?{
        return UserDefaults.standard.dictionary(forKey: storedDataUserDefaultsKey)
    }

}
