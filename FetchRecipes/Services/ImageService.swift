//
//  ImageService.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import SwiftUI

protocol ImageService {
    func loadImage(url: URL) async throws -> UIImage?
}

struct DefaultImageService: ImageService {
    private let imageLoader: ImageLoader
    private let fileService: FileService

    init(imageLoader: ImageLoader = DefaultImageLoader(), fileService: FileService = DefaultFileService()) {
        self.imageLoader = imageLoader
        self.fileService = fileService
    }

    func loadImage(url: URL) async throws -> UIImage? {
        // Check the cache first for a potential hit
        if let image = try? fileService.retrieveImage(for: url.hash) {
            return image
        }

        do {
            if let imageData = try? imageLoader.loadImage(from: url), let image = UIImage(data: imageData) {
                // Cache the image for future use
                try fileService.storeImage(image, for: url.hash)
                return image
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
