//
//  ContentView.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.friendsRepository) var friendsRepository
    @State var friendSelectedForAssignation: User? = nil
    
    var body: some View {
        List {
            ForEach(friendsRepository.friends) { friend in
                FriendCell(friend: friend) { action in
                    switch action {
                    case .didTapReaction(let reaction):
                        friendsRepository.addOrRemoveReaction(reaction.emoji, to: friend)
                    case .didTapAddReaction:
                        friendSelectedForAssignation = friend
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .background(Color("background"))
        .listStyle(.plain)
        .onAppear {
            Task {
                try? await friendsRepository.fetchFriends()
            }
        }
        .sheet(item: $friendSelectedForAssignation, content: { friend in
            EmojiPicker(
                emojis: Reaction.Emoji.allCases,
                onEmojiSelected: { emoji in
                    friendsRepository.addOrRemoveReaction(emoji, to: friend)
                    friendSelectedForAssignation = nil
                }
            )
            .presentationDragIndicator(.visible)
            .presentationDetents([.height(250)])
        })
    }
}

#Preview {
    ContentView()
}
