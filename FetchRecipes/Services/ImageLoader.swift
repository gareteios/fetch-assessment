//
//  ImageLoader.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import Foundation

protocol ImageLoader {
    func loadImage(from url: URL) throws -> Data?
}

struct DefaultImageLoader: ImageLoader {
    func loadImage(from url: URL) throws -> Data? {
        try Data(contentsOf: url)
    }
}
