//
//  FriendCell.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import SwiftUI

struct FriendCell: View {
    enum Action {
        case didTapReaction(Reaction)
        case didTapAddReaction
    }
    
    let friend: User
    let onAction: (Action) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // User section
            HStack(spacing: 16) {
                AsyncImage(url: friend.imageUrl) { result in
                    if let image = result.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        Color("gray")
                    }
                }
                .cornerRadius(25)
                .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(friend.name)
                        .font(.headline)
                        .foregroundStyle(Color("primary"))
                        .lineLimit(1)
                    Text("\(friend.timestamp.relativeDateString)")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color("gray"))
                }
            }
            
            //Summary section
            HStack(alignment: .top) {
                Text(friend.activityTitle)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .font(.title.weight(.semibold))
                    .foregroundStyle(Color("black"))
                Spacer(minLength: 16)
                Text(friend.activityMainEmoji)
                    .font(.system(size: 60))
            }
            
            reactions
        }
        .padding(.init(top: 20, leading: 30, bottom: 20, trailing: 30))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color("white")))
    }
    
    var reactions: some View {
        let reactions = friend.reactions
        let reactionsPerRow = 3
        let totalFullRows = reactions.count / reactionsPerRow
        let remainingReactions = reactions.count % reactionsPerRow
        
        //Reactions section
        return VStack(alignment: .leading) {
            ForEach(0..<totalFullRows, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<reactionsPerRow, id: \.self) { colIndex in
                        let reactionIndex = rowIndex * reactionsPerRow + colIndex
                        if reactionIndex < reactions.count {
                            buildReactionButton(reactions[reactionIndex])
                        }
                    }
                    if remainingReactions == 0, rowIndex == totalFullRows - 1 {
                        addReactionButton
                    }
                }
            }
            HStack {
                if remainingReactions > 0 {
                    ForEach(0..<remainingReactions, id: \.self) { colIndex in
                        let reactionIndex = totalFullRows * reactionsPerRow + colIndex
                        if reactionIndex < reactions.count {
                            buildReactionButton(reactions[reactionIndex])
                        }
                    }
                    addReactionButton
                } else if totalFullRows == 0 {
                    addReactionButton
                }
            }
        }
    }
    
    func buildReactionButton(_ reaction: Reaction) -> some View {
        Button {
            onAction(.didTapReaction(reaction))
        } label: {
            Text("\(reaction.emoji.rawValue) \(reaction.totalCount)")
        }
        .buttonStyle(.plain)
        .font(.caption.bold())
        .foregroundStyle(Color("gray"))
        .padding(.init(integerLiteral: 7))
        .background(
            Capsule()
                .fill(Color("secondary"))
                .stroke(reaction.isSelected ? Color("primary") : Color.clear, lineWidth: 1.5)
        )
    }
    
    var addReactionButton: some View {
        Button {
            onAction(.didTapAddReaction)
        } label: {
            Text("+")

        }
        .buttonStyle(.plain)
        .font(.headline)
        .foregroundStyle(Color("gray"))
        .padding(.init(top: 7, leading: 8, bottom: 8, trailing: 8))
        .background(Color("secondary"))
        .clipShape(Circle())
    }
}

#Preview {
    FriendCell(
        friend: .init(
            id: "1",
            userId: "1",
            imageUrl: URL(string: "https://present-osn776hbea-uc.a.run.app/charles.png")!,
            name: "Charles",
            timestamp: Date.now,
            activityTitle: "100-day 2 hour streak",
            activityMainEmoji: "🔥",
            reactions: [
                .init(emoji: .flexedBicep, count: 5, isSelected: true),
                .init(emoji: .fire, count: 3)
            ]
        )
    ) { _ in
        
    }
}
