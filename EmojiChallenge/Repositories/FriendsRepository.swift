//
//  Untitled.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import Foundation
import Observation

protocol FriendsRepository {
    func fetchFriends() async throws -> [Friend]
    func addOrRemoveReaction(_ emoji: Reaction.Emoji, to friend: Friend)
}

class FriendsRepositoryImpl: FriendsRepository {
    private let networkingService: NetworkingService
    private let urlProvider: URLProvider
    private(set) var isLoading: Bool = false
    private(set) var friends: [Friend] = []
    
    init(networkingService: NetworkingService, urlProvider: URLProvider) {
        self.networkingService = networkingService
        self.urlProvider = urlProvider
    }
    
    func fetchFriends() async throws -> [Friend] {
        return try await networkingService.request([Friend].self, request: urlProvider.getFriends)
    }
    
    func addOrRemoveReaction(_ emoji: Reaction.Emoji, to friend: Friend) {
        let reactions = friend.reactions
        guard let reaction = reactions.first (where: { $0.emoji == emoji }) else {
            friend.reactions.append(.init(emoji: emoji, isSelected: true))
            return
        }
        reaction.isSelected.toggle()
        if reaction.totalCount == 0 {
            friend.reactions.removeAll(where: { $0.emoji == emoji })
        }
    }
}
