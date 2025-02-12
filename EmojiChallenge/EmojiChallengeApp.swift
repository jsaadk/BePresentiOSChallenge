//
//  EmojiChallengeApp.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import SwiftUI

@main
struct EmojiChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            FriendsFeedView(
                friendsRepository: FriendsRepositoryImpl(
                    networkingService: NetworkingServiceImpl(),
                    urlProvider: URLProviderImpl()
                )
            )
        }
    }
}
