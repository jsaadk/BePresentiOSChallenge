//
//  FriendCell.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import SwiftUI

struct FriendCellView: View {
    private enum Constants {
        static let mainCornerRadius: CGFloat = 20
        static let mainVStackSpacing: CGFloat = 20
        static let mainPadding = EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30)
        static let avatarSize: CGFloat = 50
        static let addReactionPadding = EdgeInsets(top: 7, leading: 8, bottom: 8, trailing: 8)
        static let reactionsPerRow = 3
    }
    enum Action {
        case didTapReaction(Reaction)
        case didTapAddReaction
    }
    
    let friend: Friend
    let onAction: (Action) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.mainVStackSpacing) {
            userMetadataHeader
            activitySummary
            reactions
        }
        .padding(Constants.mainPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: Constants.mainCornerRadius)
                .fill(Color.AppTheme.white)
        )
    }
    
    var userMetadataHeader: some View {
        HStack(spacing: 16) {
            AsyncImage(url: friend.imageUrl) { result in
                if let image = result.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.AppTheme.gray
                }
            }
            .clipShape(Circle())
            .frame(width: Constants.avatarSize, height: Constants.avatarSize)
            VStack(alignment: .leading) {
                Text(friend.name)
                    .font(.headline)
                    .foregroundStyle(Color.AppTheme.primary)
                    .lineLimit(1)
                Text("\(friend.timestamp.relativeDateString)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.AppTheme.gray)
            }
        }
    }
    
    var activitySummary: some View {
        HStack(alignment: .top) {
            Text(friend.activityTitle)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .font(.title.weight(.semibold))
                .foregroundStyle(Color.AppTheme.black)
            Spacer(minLength: 16)
            Text(friend.activityMainEmoji)
                .font(.system(size: 60))
        }
    }
    
    var reactions: some View {
        let reactions = friend.reactions
        let totalFullRows = reactions.count / Constants.reactionsPerRow
        let remainingReactions = reactions.count % Constants.reactionsPerRow
        
        //Reactions section
        return VStack(alignment: .leading) {
            ForEach(0..<totalFullRows, id: \.self) { rowIndex in
                HStack {
                    ForEach(0 ..< Constants.reactionsPerRow, id: \.self) { colIndex in
                        let reactionIndex = rowIndex * Constants.reactionsPerRow + colIndex
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
                    ForEach(0 ..< remainingReactions, id: \.self) { colIndex in
                        let reactionIndex = totalFullRows * Constants.reactionsPerRow + colIndex
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
        .foregroundStyle(Color.AppTheme.gray)
        .padding(.init(integerLiteral: 7))
        .background(
            Capsule()
                .fill(Color.AppTheme.secondary)
                .stroke(reaction.isSelected ? Color.AppTheme.primary : Color.clear, lineWidth: 1.5)
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
        .foregroundStyle(Color.AppTheme.gray)
        .padding(Constants.addReactionPadding)
        .background(Color.AppTheme.secondary)
        .clipShape(Circle())
    }
}

#Preview {
    FriendCellView(
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
