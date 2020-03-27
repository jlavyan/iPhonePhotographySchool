//
//  Video.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Foundation
import SwiftUI
import RxSwift
struct Video: Hashable, Identifiable, Codable {
    var id: Int
    var name: String
    var tnumbnail: String
    var description: String
    var videoLink: String
    
    
    init(dictionary: [String: Any]){
        id = dictionary["id"] as! Int
        name = dictionary["name"] as! String
        tnumbnail = dictionary["thumbnail"] as! String
        description = dictionary["description"] as! String
        videoLink = dictionary["video_link"] as! String
    }
}
