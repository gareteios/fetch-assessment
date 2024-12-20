//
//  FixtureHelper.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import Foundation
@testable import FetchRecipes

struct Fixture {
    let filename: String
    let fileExtension: String
    var jsonDecoder: JSONDecoder?

    func load<T: Decodable>(_ type: T.Type) throws -> T {
        try (jsonDecoder ?? defaultJsonDecoder).decode(type, from: try data()!)
    }

    func data() throws -> Data? {
        let bundle = Bundle.allBundles.first { $0.bundlePath.contains("FetchRecipesTests") }!
        let url = bundle.url(forResource: filename, withExtension: fileExtension)!
        return try Data(contentsOf: url)
    }

    private var defaultJsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension Fixture {
    static var allRecipes: Fixture {
        .init(filename: "Recipes_GET_all", fileExtension: "json")
    }

    static var emptyRecipes: Fixture {
        .init(filename: "Recipes_GET_empty", fileExtension: "json")
    }

    static var malformedRecipes: Fixture {
        .init(filename: "Recipes_GET_malformed", fileExtension: "json")
    }
}
