//
//  Environment.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import SwiftUI

private struct RepositoryKey: EnvironmentKey {
    static let defaultValue = FriendsRepositoryWrapper(
        underlyingRepository: FriendsRepositoryImpl(
            networkingService: NetworkingService()
        )
    )
}

extension EnvironmentValues {
    var friendsRepository: FriendsRepositoryWrapper {
        get {
            return self[RepositoryKey.self]
        }
        set {
            self[RepositoryKey.self] = newValue
        }
    }
}

@Observable class FriendsRepositoryWrapper: FriendsRepository {
    private let underlyingRepository: FriendsRepository
    
    init(underlyingRepository: FriendsRepository) {
        self.underlyingRepository = underlyingRepository
    }
    
    var isLoading: Bool {
        underlyingRepository.isLoading
    }
    
    var friends: [User] {
        underlyingRepository.friends
    }
    
    func fetchFriends() async throws {
        try await underlyingRepository.fetchFriends()
    }
    
    func addOrRemoveReaction(_ emoji: Reaction.Emoji, to friend: User) {
        underlyingRepository.addOrRemoveReaction(emoji, to: friend)
    }
}
