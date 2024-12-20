//
//  FileService.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import UIKit

protocol FileService {
    func storeImage(_ image: UIImage, for key: String) throws
    func retrieveImage(for key: String) throws -> UIImage?
}

struct DefaultFileService: FileService {
    private static var imagesPath: URL? {
        FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("image_cache")
    }

    init() {
        if let imagesPath = DefaultFileService.imagesPath, !FileManager.default.fileExists(atPath: imagesPath.path()) {
            try? FileManager.default.createDirectory(at: imagesPath, withIntermediateDirectories: true)
        }
    }

    func storeImage(_ image: UIImage, for key: String) throws {
        guard let imagesPath = DefaultFileService.imagesPath, let imageData = image.pngData() else {
            return
        }

        try imageData.write(to: imagesPath.appendingPathComponent(key), options: [Data.WritingOptions.atomic])
    }

    func retrieveImage(for key: String) throws -> UIImage? {
        guard let imagesPath = DefaultFileService.imagesPath, FileManager.default.fileExists(atPath: imagesPath.appendingPathComponent(key).path()) else {
            return nil
        }

        return UIImage(contentsOfFile: imagesPath.appendingPathComponent(key).path())
    }
}
