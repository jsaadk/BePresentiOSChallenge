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
        let mockRepository = MockFriendsRepository(isLoading: true, friends: [])
        
        var friendsListView = await FriendsFeedView()
            .environment(
                \.friendsRepository,
                 FriendsRepositoryWrapper(underlyingRepository: mockRepository)
            )
        
        print(friendsListView)
        
        await confirmation { confirmation in
            mockRepository.fetchFriendsClosure = {
                confirmation.confirm()
            }
        }
    }
}
