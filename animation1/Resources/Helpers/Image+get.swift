//
//  Image+get.swift
//  animation1
//
//  Created by Adriano Rezena on 24/08/23.
//

import SwiftUI

enum Images: String {
    case bg = "pexels-josh-hild-2422259"
}

extension Image {
    
    static func get(_ image: Images) -> Image {
        Image(image.rawValue)
    }
    
}
