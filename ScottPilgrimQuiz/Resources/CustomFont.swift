//
//  CustomTypography.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 6/3/24.
//

import Foundation
import SwiftUI

struct CustomFont {
    static func dusty(size: CGFloat) -> Font {
        .custom("Dusty", size: size)
    }
    
    static func superfly(size: CGFloat) -> Font {
        .custom("SUPERFLY", size: size)
    }
    
    private init() {}
}
