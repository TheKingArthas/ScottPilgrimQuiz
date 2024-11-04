//
//  CustomColor.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 6/3/24.
//

import Foundation
import SwiftUI

struct CustomColor {
    static var background: Color { Color("BackgroundColor") }
    static var backgroundDestructive: Color { Color("BackgroundDestructiveColor") }
    static var black: Color { .black }
    static var destructive: Color { Color("DestructiveColor") }
    static var disabled: Color { .gray }
    static var positive: Color { Color("PositiveColor") }
    static var primary: Color { Color("PrimaryColor") }
    static var secondary: Color { Color("SecondaryColor") }
    static var white: Color { .white }
    
    private init() {}
}
