//
//  User.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import Foundation
import Observation

@Observable class Friend: Decodable, Identifiable {
    let id: String
    let userId: String
    let imageUrl: URL
    let name: String
    let timestamp: Date
    let activityTitle: String
    let activityMainEmoji: String
    let relativeTimestamp: String
    var reactions: [Reaction]
    
    enum CodingKeys: String, CodingKey {
        case userId
        case imageUrl
        case name
        case timestamp
        case activityTitle
        case activityMainEmoji
        case reactions
    }
    
    init(
        id: String = UUID().uuidString,
        userId: String,
        imageUrl: URL,
        name: String,
        timestamp: Date,
        activityTitle: String,
        activityMainEmoji: String,
        reactions: [Reaction]
    ) {
        self.id = id
        self.userId = userId
        self.imageUrl = imageUrl
        self.name = name
        self.timestamp = timestamp
        self.relativeTimestamp = timestamp.relativeDateString
        self.activityTitle = activityTitle
        self.activityMainEmoji = activityMainEmoji
        self.reactions = reactions
    }
    
    convenience required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let reactionsDictionary = try container.decode([String: Int].self, forKey: .reactions)
        let reactions = reactionsDictionary.compactMap { key, value in
            return Reaction(emoji: key, count: value)
        }
        self.init(
            userId: try container.decode(String.self, forKey: .userId),
            imageUrl: try container.decode(URL.self, forKey: .imageUrl),
            name: try container.decode(String.self, forKey: .name),
            timestamp: try container.decode(Date.self, forKey: .timestamp),
            activityTitle: try container.decode(String.self, forKey: .activityTitle),
            activityMainEmoji: try container.decode(String.self, forKey: .activityMainEmoji),
            reactions: reactions
        )
    }
}
