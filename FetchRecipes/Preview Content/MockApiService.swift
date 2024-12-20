//
//  MockApiService.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import Foundation

let mockRecipe = Recipe.init(
    cuisine: "British",
    name: "Apple & Blackberry Crumble",
    photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg"),
    photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg"),
    sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble"),
    uuid: "1234",
    youtubeUrl: URL(string: "https://www.youtube.com/watch?v=4vhcOwVBDO4")
)

struct MockApiService: ApiService {
    var simulatedError: Error?
    var simulatedResponse: Decodable?
    var simulatedProcess: (() throws -> Decodable)?

    func execute<R>(_ request: R) async throws -> R.Response where R : ApiRequest {
        if let simulatedError {
            throw simulatedError
        }

        if let simulatedResponse {
            return simulatedResponse as! R.Response
        }

        if let simulatedProcess {
            return try simulatedProcess() as! R.Response
        }

        throw PreviewApiServiceError.noAction
    }
}

enum PreviewApiServiceError: Error {
    case noAction
}
