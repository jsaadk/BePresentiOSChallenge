//
//  User+Placeholder.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 11/2/25.
//

import Foundation

extension Friend {
    static var placeholders: [Friend] {
        [
            .init(
                id: "placeholder-1",
                userId: "1",
                imageUrl: URL.temporaryDirectory,
                name: "Lorem",
                timestamp: Date.now,
                activityTitle: "Lorem ipsum dolor sit amet, consectetur",
                activityMainEmoji: "🔥",
                reactions: [
                    .init(emoji: .flexedBicep, count: 5),
                    .init(emoji: .fire, count: 3)
                ]
            ),
            .init(
                id: "placeholder-2",
                userId: "2",
                imageUrl: URL.temporaryDirectory,
                name: "Lorem",
                timestamp: Date.now,
                activityTitle: "Lorem ipsum dolor sit amet, consectetur",
                activityMainEmoji: "🔥",
                reactions: [
                    .init(emoji: .flexedBicep, count: 5),
                    .init(emoji: .fire, count: 3)
                ]
            ),
            .init(
                id: "placeholder-3",
                userId: "3",
                imageUrl: URL.temporaryDirectory,
                name: "Lorem",
                timestamp: Date.now,
                activityTitle: "Lorem ipsum dolor sit amet, consectetur",
                activityMainEmoji: "🔥",
                reactions: [
                    .init(emoji: .flexedBicep, count: 5),
                    .init(emoji: .fire, count: 3)
                ]
            )
        ]
    }
}
