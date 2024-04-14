//
//  ImageLoader.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/14/24.
//

import Foundation
import SwiftUI

class ImageLoader {
    static func image(for stringToHash: String) -> Image {
        let hashedString = stringToHash.hashValue
        let sandImageNumber = abs(hashedString) % sandImageCount + 1
        print(stringToHash)
        return Image("sand\(sandImageNumber)")
    }
    
    static var sandImageCount: Int {
        var count = 0
        for i in 1...10000 {
            guard UIImage(named: "sand\(i)") != nil else {
                return count
            }
            count += 1
        }
        return count
    }
}
