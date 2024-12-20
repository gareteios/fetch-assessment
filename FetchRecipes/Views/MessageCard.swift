//
//  MessageCard.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import SwiftUI

struct MessageCard: View {
    let icon: String?
    let title: String
    let message: String?

    init(icon: String? = nil, title: String, message: String? = nil) {
        self.icon = icon
        self.title = title
        self.message = message
    }

    var body: some View {
        VStack(alignment: .center, spacing: Spacing.x4) {
            if let icon {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 75, height: 75)
            }

            VStack(spacing: Spacing.x1) {
                Text(title)
                    .font(.headline)

                if let message {
                    Text(message)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding(Spacing.x4)
    }
}

extension MessageCard {
    public static func error(title: String, message: String?) -> MessageCard {
        .init(icon: "exclamationmark.triangle", title: title, message: message)
    }
}

#Preview {
    MessageCard.error(title: "Something Went Wrong", message: "...and we're sorry about that. Please try again later.")
}

#Preview {
    MessageCard.error(title: "Something Went Wrong", message: "...and we're sorry about that. But to make it up to you, we're going to put a lot of text here that you will probably read. But really, it's just a way for us to text this component. Got ya! Please try again later.")
}

#Preview {
    MessageCard.error(title: "Something Went Wrong", message: nil)
}
