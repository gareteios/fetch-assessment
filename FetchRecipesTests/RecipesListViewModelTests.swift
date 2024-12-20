//
//  RecipesListViewModelTests.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import XCTest
@testable import FetchRecipes

@MainActor
final class RecipesListViewModelTests: XCTestCase {
    func test_isLoaded_withRecipes() async {
        let response = try! Fixture.allRecipes.load(RecipesResponse.self)
        let viewState = RecipesListViewModel(
            apiService: MockApiService(
                simulatedResponse: response
            )
        )

        await viewState.fetchRecipes()

        guard case .loaded(let recipes) = viewState.listState else {
            XCTFail("Should be loaded")
            return
        }

        XCTAssertEqual(recipes.count, response.recipes.count)
    }

    func test_isLoaded_withEmptyRecipes() async {
        let viewState = RecipesListViewModel(
            apiService: MockApiService(
                simulatedResponse: try! Fixture.emptyRecipes.load(RecipesResponse.self)
            )
        )

        await viewState.fetchRecipes()

        guard case .loaded(let recipes) = viewState.listState else {
            XCTFail("Should be loaded")
            return
        }

        XCTAssertTrue(recipes.isEmpty)
    }

    func test_error_withMalformedResponse() async {
        let viewState = RecipesListViewModel(
            apiService: MockApiService(
                simulatedError: ApiError.invalidRequest
            )
        )

        await viewState.fetchRecipes()

        guard case .error(ApiError.invalidRequest) = viewState.listState else {
            XCTFail("Should have errored out with an invalidRequest error")
            return
        }
    }
}
