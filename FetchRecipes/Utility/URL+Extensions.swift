//
//  URL+Extensions.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import Foundation

extension URL {
    var hash: String {
        Data(absoluteString.utf8).base64EncodedString().replacingOccurrences(of: "=", with: "")
    }
}
