//
//  MockImageLoader.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import Foundation
import UIKit
@testable import FetchRecipes

class MockImageLoader: ImageLoader {
    var loadImageCalled: Bool = false

    func loadImage(from url: URL) throws -> Data? {
        loadImageCalled = true
        
        let bundle = Bundle(for: MockImageLoader.self)
        let imagePath = bundle.url(forResource: "cake", withExtension: "png")!
        return try Data(contentsOf: imagePath)
    }
}
