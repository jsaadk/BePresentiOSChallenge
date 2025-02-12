//
//  EmojiPicker.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 9/2/25.
//

import SwiftUI


struct EmojiPickerView: View {
    let emojis: [Reaction.Emoji]
    let onEmojiSelected: (Reaction.Emoji) -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Text("React with an emoji")
                .font(.caption.bold())
                .foregroundStyle(Color.AppTheme.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 5)
            
            let itemsPerRow = 6
            let totalRows = emojis.count / itemsPerRow
            ForEach(0..<totalRows, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<itemsPerRow, id: \.self) { colIndex in
                        let index = rowIndex * itemsPerRow + colIndex
                        let item = emojis[index]
                        Button {
                            onEmojiSelected(item)
                        } label: {
                            Text(item.rawValue)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .font(.title)
            }
            Spacer()
        }
        .padding(.init(top: 40, leading: 30, bottom: 30, trailing: 30))
        .background(Color.AppTheme.background)
    }
}


#Preview {
    EmojiPickerView(emojis: Reaction.Emoji.allCases) { _ in
        
    }
}
