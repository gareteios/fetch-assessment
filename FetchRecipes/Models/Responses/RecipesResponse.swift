//
//  RecipesResponse.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

struct RecipesResponse: Decodable, Equatable {
    let recipes: [Recipe]
}
