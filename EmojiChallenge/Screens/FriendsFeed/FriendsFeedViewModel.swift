//
//  FriendsFeedViewModel.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 11/2/25.
//

import Observation

@Observable class FriendsFeedViewModel {
    private let friendsRepository: FriendsRepository
    var isLoading: Bool = false
    var friends: [Friend]
    var reactingToFriend: Friend?
    var placeholderFriends: [Friend] {
        Friend.placeholders
    }
    
    init(friendsRepository: FriendsRepository,
         isLoading: Bool = true,
         friends: [Friend] = [],
         reactingToFriend: Friend? = nil
    ) {
        self.friendsRepository = friendsRepository
        self.isLoading = isLoading
        self.friends = friends
        self.reactingToFriend = reactingToFriend
    }
    
    func fetchFriends(forceRefresh: Bool = false) {
        guard friends.isEmpty || forceRefresh else {
            return
        }
        isLoading = true
        Task {
            do {
                friends = try await friendsRepository.fetchFriends()
            } catch {
                // No error handling in current design
            }
            isLoading = false
        }
    }
    
    func applyReaction(_ emoji: Reaction.Emoji, to friend: Friend) {
        friendsRepository.addOrRemoveReaction(
            emoji,
            to: friend
        )
    }
    
    func applyReactionToSelectedFriend(_ emoji: Reaction.Emoji) {
        guard let reactingToFriend else {
            return
        }
        applyReaction(emoji, to: reactingToFriend)
    }
}
