//
//  RecipesListViewModel.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import SwiftUI

@MainActor
class RecipesListViewModel: ObservableObject {
    @Published var listState: ListState = .loading

    private let apiService: ApiService

    enum ListState {
        case loading
        case loaded([Recipe])
        case error(Error)
    }

    init(apiService: ApiService) {
        self.apiService = apiService
    }

    func fetchRecipes() async {
        do {
            let response = try await apiService.execute(FetchRecipesRequest())
            listState = .loaded(response.recipes)
        } catch {
            listState = .error(error)
        }
    }

    // With more time, would love to make this a popover select so the user
    // could decide what they want to see
    func recipeSelected(_ recipe: Recipe) {
        if let youtubeUrl = recipe.youtubeUrl {
            UIApplication.shared.open(youtubeUrl)
            return
        }

        if let sourceUrl = recipe.sourceUrl {
            UIApplication.shared.open(sourceUrl)
            return
        }
    }
}
