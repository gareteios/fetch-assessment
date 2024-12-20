//
//  DefaultImageServiceTests.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import XCTest
@testable import FetchRecipes

@MainActor
final class DefaultImageServiceTests: XCTestCase {
    var sut: DefaultImageService!
    var mockImageLoader: MockImageLoader!
    var mockFileService: MockFileService!

    private let dummyUrl = URL(string: "https://apple.com")!

    override func setUp() {
        super.setUp()

        mockImageLoader = MockImageLoader()
        mockFileService = MockFileService()
        sut = DefaultImageService(imageLoader: mockImageLoader, fileService: mockFileService)
    }

    func test_loadsImage_andThenSavesToCache() async {
        let image = try! await sut.loadImage(url: dummyUrl)

        XCTAssertNotNil(image)
        XCTAssertNotNil(mockFileService.cache[dummyUrl.hash])
    }

    func test_doesNotMakeApiCall_whenPresentInCache() async {
        let image = UIImage()
        mockFileService.cache[dummyUrl.hash] = image

        let cachedImage = try! await sut.loadImage(url: dummyUrl)

        XCTAssertFalse(mockImageLoader.loadImageCalled)
        XCTAssertEqual(image, cachedImage)
    }
}
