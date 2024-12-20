//
//  RemoteImage.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import SwiftUI

struct RemoteImage: View {
    let url: URL

    @State private var image: UIImage?

    // With more time / larger project, would use DI for this
    private static let imageService: ImageService = DefaultImageService()

    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            Color.gray.opacity(0.5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    Task {
                        try? await fetchImage()
                    }
                }
        }
    }

    private func fetchImage() async throws {
        if let image = try? await RemoteImage.imageService.loadImage(url: url) {
            withAnimation {
                self.image = image
            }
        }
    }
}
