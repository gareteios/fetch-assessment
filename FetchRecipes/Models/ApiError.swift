//
//  APIError.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

enum ApiError: Error {
    case invalidRequest
    case invalidStatusCode(Int)
    case decodingFailed(Error)
    case unknownError(Error)
}
