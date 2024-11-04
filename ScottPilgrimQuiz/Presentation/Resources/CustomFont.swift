//
//  CustomTypography.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 6/3/24.
//

import Foundation
import SwiftUI

enum FontWeight {
    case bold, medium
}

struct CustomFont {
    static func karmaticArcade(size: CGFloat) -> Font { .custom("Karmatic Arcade", size: size) }
    static func montserrat(size: CGFloat, weight: FontWeight) -> Font {
        switch weight {
        case .bold:
            montserratBold(size: size)
        case .medium:
            montserratMedium(size: size)
        }
    }

    private static func montserratBold(size: CGFloat) -> Font { .custom("Montserrat-Bold", size: size) }
    private static func montserratMedium(size: CGFloat) -> Font { .custom("Montserrat-Medium", size: size) }

    private init() {}
}
