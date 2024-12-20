//
//  FetchRecipesApp.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import SwiftUI

@main
struct FetchRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            RecipesList(apiService: DefaultApiService())
        }
    }
}
