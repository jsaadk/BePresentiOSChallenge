//
//  Reaction.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import Foundation
import Observation

@Observable class Reaction {
    enum Emoji: String, CaseIterable {
        case thumbsUp = "👍"
        case thumbsDown = "👎"
        case flexedBicep = "💪"
        case salutingFace = "🫡"
        case handsRaised = "🙌"
        case partyFace = "🥳"
        case fire = "🔥"
        case partyPopper = "🎉"
        case noMobilePhone = "📵"
        case faceWithSteamFromNose = "😤"
        case personInLotusPosition = "🧘"
        case eyes = "👀"
        case flushedFace = "😳"
        case skull = "💀"
        case womanFacepalming = "🤦‍♀️"
        case grinningFaceWithSweat = "😅"
        case meltingFace = "🫠"
        case upsideDownFace = "🙃"
    }
    
    let emoji: Emoji
    let count: Int
    var isSelected: Bool
    var totalCount: Int {
        count + (isSelected ? 1 : 0)
    }
    
    init(emoji: Emoji, count: Int = 0, isSelected: Bool = false) {
        self.emoji = emoji
        self.count = count
        self.isSelected = isSelected
    }
    
    convenience init?(emoji: String, count: Int) {
        guard let emoji = Emoji(rawValue: emoji) else {
            return nil
        }
        self.init(emoji: emoji, count: count)
    }
}
