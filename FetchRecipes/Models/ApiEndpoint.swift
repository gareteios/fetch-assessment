//
//  ApiEndpoint.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import Foundation

enum ApiEndpoint: String {
    case production

    var url: URL {
        switch self {
        case .production:
            return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")!
        }
    }
}
