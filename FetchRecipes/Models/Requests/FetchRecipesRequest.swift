//
//  FetchRecipesRequest.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

struct FetchRecipesRequest: ApiRequest {
    typealias Response = RecipesResponse
    
    let path: String = "/recipes.json"
}
