//
//  ApiService.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import Foundation

protocol ApiService {
    func execute<R>(_ request: R) async throws -> R.Response where R : ApiRequest
}

struct DefaultApiService: ApiService {
    private let apiEndpoint: ApiEndpoint
    private let urlSession: URLSession

    init(apiEndpoint: ApiEndpoint = .production, urlSession: URLSession = .shared) {
        self.apiEndpoint = apiEndpoint
        self.urlSession = urlSession
    }

    func execute<R>(_ request: R) async throws -> R.Response where R : ApiRequest {
        guard let urlRequest = request.urlRequest(with: apiEndpoint) else {
            throw ApiError.invalidRequest
        }

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw ApiError.invalidStatusCode(-1)
            }

            guard request.acceptableResponseCodes.contains(statusCode) else {
                throw ApiError.invalidStatusCode(statusCode)
            }

            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            return try jsonDecoder.decode(R.Response.self, from: data)
        } catch let error as ApiError {
            throw error
        } catch let error as DecodingError {
            throw ApiError.decodingFailed(error)
        } catch {
            throw ApiError.unknownError(error)
        }
    }
}
