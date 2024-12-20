//
//  RecipeCard.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    let isCompact: Bool

    init(recipe: Recipe, isCompact: Bool = false) {
        self.recipe = recipe
        self.isCompact = isCompact
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.x2) {
            if let imageUrl = recipe.photoUrlLarge {
                RemoteImage(url: imageUrl)
                    .cornerRadius(CornerRadius.medium)
                    .clipped()
                    .aspectRatio(1.0, contentMode: .fit)
            }

            let name = Text(recipe.name)
                .font(.headline)
                .lineLimit(2)

            let cuisine = Text(recipe.cuisine.capitalized)
                .font(.caption)
                .foregroundColor(.secondary)

            if isCompact {
                VStack(alignment: .leading, spacing: Spacing.x1) {
                    name
                    cuisine
                }
                .padding(.horizontal, Spacing.x1)
            } else {
                HStack(alignment: .center, spacing: Spacing.x4) {
                    name
                    Spacer()
                    cuisine
                }
                .padding(.horizontal, Spacing.x3)
            }

            if isCompact {
                Spacer()
            }
        }
    }
}

#Preview {
    RecipeCard(recipe: mockRecipe)
}

#Preview {
    RecipeCard(recipe: mockRecipe, isCompact: true)
}
