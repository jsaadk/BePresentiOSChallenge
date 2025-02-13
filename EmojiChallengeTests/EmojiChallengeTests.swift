//
//  EmojiChallengeTests.swift
//  EmojiChallengeTests
//
//  Created by Jose Saad on 8/2/25.
//

import Testing
@testable import EmojiChallenge

struct EmojiChallengeTests {
    @Test func example() async throws {
        let mockRepository = MockFriendsRepository(friendsToReturn: [])
        
        let friendsListView = await FriendsFeedView(friendsRepository: mockRepository)
       
        await confirmation { confitmation in
            mockRepository.fetchFriendsClosure = {
                confitmation.confirm()
            }
            await friendsListView.fetchFriends().value
        }
    }
}
