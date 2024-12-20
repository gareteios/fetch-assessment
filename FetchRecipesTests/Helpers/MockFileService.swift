//
//  MockFileService.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import UIKit
@testable import FetchRecipes

class MockFileService: FileService {
    var cache: [String: UIImage] = [:]

    func storeImage(_ image: UIImage, for key: String) throws {
        cache[key] = image
    }
    
    func retrieveImage(for key: String) throws -> UIImage? {
        cache[key]
    }
}
