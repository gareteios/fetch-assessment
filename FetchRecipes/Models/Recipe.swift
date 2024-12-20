//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/19/24.
//

import Foundation

struct Recipe: Codable, Identifiable, Equatable {
    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let sourceUrl: URL?
    let uuid: String
    let youtubeUrl: URL?

    // MARK: Identifiable
    var id: String { uuid }
}
