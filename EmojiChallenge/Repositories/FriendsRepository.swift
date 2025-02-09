//
//  Untitled.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import Foundation
import Observation

enum Router {
    private static let baseURL = URL(string: "https://present-osn776hbea-uc.a.run.app/codingChallenge/")!
    case getFriends
    
    var asURLRequest: URLRequest {
        switch self {
        case .getFriends:
            return URLRequest(url: Self.baseURL.appendingPathComponent("friendsActivity"))
        }
    }
}

protocol FriendsRepository: Observable {
    var isLoading: Bool { get }
    var friends: [User] { get }
    func fetchFriends() async throws
    func addOrRemoveReaction(_ emoji: Reaction.Emoji, to friend: User)
}

@Observable class FriendsRepositoryImpl: FriendsRepository {
    private let networkingService: NetworkingService
    private(set) var isLoading: Bool = false
    private(set) var friends: [User] = []
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func fetchFriends() async throws {
        isLoading = true
        friends = try await networkingService.request([User].self, request: Router.getFriends.asURLRequest)
        isLoading = false
    }
    
    func addOrRemoveReaction(_ emoji: Reaction.Emoji, to friend: User) {
        let reactions = friend.reactions
        guard let reaction = reactions.first (where: { $0.emoji == emoji }) else {
            friend.reactions.append(.init(emoji: emoji, isSelected: true))
            return
        }
        reaction.isSelected.toggle()
    }
}
