//
//  ContentView.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import SwiftUI

struct FriendsFeedView: View {
    @State private var viewModel: FriendsFeedViewModel
    
    init(friendsRepository: FriendsRepository) {
        self.viewModel = .init(friendsRepository: friendsRepository)
    }
    
    var body: some View {
        NavigationStack {
            List {
                let friends = viewModel.isLoading
                ? viewModel.placeholderFriends
                : viewModel.friends
                let elements = ForEach(friends) { friend in
                    FriendCell(friend: friend) { action in
                        switch action {
                        case .didTapReaction(let reaction):
                            viewModel.applyReaction(reaction.emoji, to: friend)
                        case .didTapAddReaction:
                            viewModel.reactingToFriend = friend
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                
                if viewModel.isLoading {
                    elements.redacted(reason: .placeholder)
                } else {
                    elements
                }
            }
            .background(Color.AppTheme.background)
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchFriends()
            }
            .sheet(item: $viewModel.reactingToFriend, content: { friend in
                EmojiPicker(
                    emojis: Reaction.Emoji.allCases,
                    onEmojiSelected: { emoji in
                        viewModel.applyReactionToSelectedFriend(emoji)
                        viewModel.reactingToFriend = nil
                    }
                )
                .presentationDragIndicator(.visible)
                .presentationDetents([.height(250)])
            })
            .navigationTitle("Friends Feed")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Refresh") {
                        viewModel.fetchFriends(forceRefresh: true)
                    }
                }
            })
            .toolbarBackground(
                Color.AppTheme.background,
                for: .navigationBar
            )
        }
    }
}

#Preview {
    FriendsFeedView(
        friendsRepository:
            MockFriendsRepository(
                friendsToReturn: [
                    .init(
                        id: "1",
                        userId: "1",
                        imageUrl: URL(string: "https://present-osn776hbea-uc.a.run.app/charles.png")!,
                        name: "Charles",
                        timestamp: .now,
                        activityTitle: "100-day 2 hour streak",
                        activityMainEmoji: "🔥",
                        reactions: [
                            .init(emoji: .flexedBicep, count: 5),
                            .init(emoji: .fire, count: 3)
                        ]
                    ),
                    .init(
                        id: "2",
                        userId: "2",
                        imageUrl: URL(string: "https://present-osn776hbea-uc.a.run.app/el.png")!,
                        name: "El",
                        timestamp: .now,
                        activityTitle: "6 hours spent on TikTok",
                        activityMainEmoji: "🤦‍♀️",
                        reactions: [
                            .init(emoji: .flushedFace, count: 8, isSelected: true),
                            .init(emoji: .eyes, count: 4)
                        ]
                    ),
                    .init(
                        id: "3",
                        userId: "3",
                        imageUrl: URL(string: "https://present-osn776hbea-uc.a.run.app/jack.png")!,
                        name: "Jack",
                        timestamp: .now,
                        activityTitle: "Completed 5 hour Present Session",
                        activityMainEmoji: "🧘",
                        reactions: [
                            .init(emoji: .thumbsUp, count: 8),
                            .init(emoji: .partyPopper, count: 4)
                        ]
                    )
                ]
            )
    )
}
