//
//  User.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import Foundation
import Observation

@Observable public class Friend: Decodable, Identifiable {
    public let id: String = UUID().uuidString
    public let userId: String
    public let imageUrl: URL
    public let name: String
    public let timestamp: Date
    public let activityTitle: String
    public let activityMainEmoji: String
    public var reactions: [Reaction]
    
    enum CodingKeys: String, CodingKey {
        case userId
        case imageUrl
        case name
        case timestamp
        case activityTitle
        case activityMainEmoji
        case reactions
    }
    
    public init(
        id: String,
        userId: String,
        imageUrl: URL,
        name: String,
        timestamp: Date,
        activityTitle: String,
        activityMainEmoji: String,
        reactions: [Reaction]
    ) {
        self.userId = userId
        self.imageUrl = imageUrl
        self.name = name
        self.timestamp = timestamp
        self.activityTitle = activityTitle
        self.activityMainEmoji = activityMainEmoji
        self.reactions = reactions
    }
    
    required public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.imageUrl = try container.decode(URL.self, forKey: .imageUrl)
        self.name = try container.decode(String.self, forKey: .name)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.activityTitle = try container.decode(String.self, forKey: .activityTitle)
        self.activityMainEmoji = try container.decode(String.self, forKey: .activityMainEmoji)

        let reactionsDictionary = try container.decode([String: Int].self, forKey: .reactions)
        self.reactions = reactionsDictionary.compactMap { key, value in
            return Reaction(emoji: key, count: value)
        }
    }
}
