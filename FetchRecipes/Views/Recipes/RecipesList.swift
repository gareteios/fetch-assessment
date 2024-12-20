//
//  RecipesList.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import SwiftUI

struct RecipesList: View {
    @StateObject
    private var viewModel: RecipesListViewModel

    @State private var selectedLayout = Layout.list

    init(apiService: ApiService) {
        _viewModel = StateObject(wrappedValue: RecipesListViewModel(apiService: apiService))
    }

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.listState {
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .loaded(let recipes) where recipes.isEmpty:
                    empty
                case .loaded(let recipes):
                    switch selectedLayout {
                    case .list:
                        list(with: recipes)
                    case .grid:
                        grid(with: recipes)
                    }
                case .error:
                    error
                }
            }
            .navigationTitle(Text("Recipes"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu(content: {
                        Picker("Layout", selection: $selectedLayout) {
                            ForEach(Layout.allCases, id: \.self) { option in
                                Label(
                                    option.title,
                                    systemImage: option.icon
                                )
                            }
                        }
                    }, label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundStyle(.foreground)
                    })
                }
            }
        }
        .onAppear { Task { await viewModel.fetchRecipes() } }
    }

    var empty: MessageCard {
        MessageCard(
            title: "No Recipes for You",
            message: "Give us a little bit of time to whip up some new recipes for you! Check back soon."
        )
    }

    var error: MessageCard {
        MessageCard.error(
            title: "Something Went Wrong",
            message: "...and we're sorry about that. Please give us another shot later."
        )
    }

    func list(with recipes: [Recipe]) -> some View {
        List {
            ForEach(recipes) { recipe in
                RecipeCard(
                    recipe: recipe
                )
                .listRowSeparator(.hidden)
                .onTapGesture {
                    viewModel.recipeSelected(recipe)
                }
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }

    func grid(with recipes: [Recipe]) -> some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        
        return ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(recipes) { recipe in
                    RecipeCard(
                        recipe: recipe,
                        isCompact: true
                    )
                    .onTapGesture {
                        viewModel.recipeSelected(recipe)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, Spacing.x2)
    }

    enum Layout: CaseIterable {
        case list
        case grid

        var title: String {
            switch self {
            case .list:
                return "List"
            case .grid:
                return "Grid"
            }
        }

        var icon: String {
            switch self {
            case .list:
                return "square.stack"
            case .grid:
                return "square.grid.2x2"
            }
        }
    }
}

#Preview {
    RecipesList(apiService: MockApiService(simulatedResponse: RecipesResponse(recipes: [mockRecipe])))
}

#Preview {
    RecipesList(apiService: MockApiService(simulatedResponse: RecipesResponse(recipes: [])))
}

#Preview {
    RecipesList(apiService: MockApiService(simulatedError: ApiError.invalidRequest))
}
