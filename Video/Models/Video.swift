//
//  Video.swift
//  Video
//
//  Created by Jlavyan on 3/27/20.
//  Copyright © 2020 Jlavyan. All rights reserved.
//

import Foundation
import SwiftUI

struct Video: Hashable, Identifiable, Decodable {
    var id: String
    var name: String
    var tnumbnail: URL
    var description: String
    var videoLink: URL
}
