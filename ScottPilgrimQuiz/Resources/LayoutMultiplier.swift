//
//  LayoutMultiplier.swift
//  ScottPilgrimQuiz
//
//  Created by Federico De Luca on 6/3/24.
//

import Foundation

struct LayoutMultiplier {
    static func padding(_ multiplier: CGFloat) -> CGFloat { 8 * multiplier }
    static func size(_ multiplier: CGFloat) -> CGFloat { 8 * multiplier }
    
    private init() {}
}
