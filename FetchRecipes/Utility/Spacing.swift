//
//  Spacing.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import CoreGraphics

enum Spacing {
    static let x1: CGFloat = 4
    static let x2: CGFloat = 8
    static let x3: CGFloat = 12
    static let x4: CGFloat = 16

    static func x(_ value: Int) -> CGFloat {
        CGFloat(value) * x1
    }
}
