//
//  Untitled.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 11/2/25.
//

import Observation

class MockFriendsRepository: FriendsRepository {
    var friendsToReturn: [EmojiChallenge.Friend]
    var fetchFriendsClosure: (() -> Void)?
    var addOrRemoveReactionClosure: ((EmojiChallenge.Reaction.Emoji, EmojiChallenge.Friend) -> Void)?
    
    init(
        friendsToReturn: [EmojiChallenge.Friend],
        fetchFriendsClosure: (() -> Void)? = nil,
        addOrRemoveReactionClosure: ((EmojiChallenge.Reaction.Emoji, EmojiChallenge.Friend) -> Void)? = nil
    ) {
        self.friendsToReturn = friendsToReturn
        self.fetchFriendsClosure = fetchFriendsClosure
        self.addOrRemoveReactionClosure = addOrRemoveReactionClosure
    }
    
    func fetchFriends() async throws -> [Friend] {
        fetchFriendsClosure?()
        return friendsToReturn
    }
    
    func addOrRemoveReaction(_ emoji: EmojiChallenge.Reaction.Emoji, to friend: EmojiChallenge.Friend) {
        addOrRemoveReactionClosure?(emoji, friend)
    }
}
