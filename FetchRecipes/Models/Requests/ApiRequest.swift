//
//  ApiRequest.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import Foundation

protocol ApiRequest {
    associatedtype Response: Decodable

    var acceptableResponseCodes: Range<Int> { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }

    func urlRequest(with apiEndpoint: ApiEndpoint) -> URLRequest?
}

extension ApiRequest {
    var acceptableResponseCodes: Range<Int> { 200..<300 }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }

    func urlRequest(with apiEndpoint: ApiEndpoint) -> URLRequest? {
        guard var components = URLComponents(url: apiEndpoint.url, resolvingAgainstBaseURL: false) else { return nil }

        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
}

enum HTTPMethod: String {
    case get
    // Obviously this would grow with more APIs! KISS for now :)
}
