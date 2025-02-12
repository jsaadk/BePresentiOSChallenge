//
//  UrlProvider.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 11/2/25.
//

import Foundation

protocol URLProvider {
    var getFriends: URLRequest { get }
}

struct URLProviderImpl: URLProvider {
    private static let baseURL = URL(string: "https://present-osn776hbea-uc.a.run.app/codingChallenge/")!
    
    var getFriends: URLRequest {
        URLRequest(url: Self.baseURL.appendingPathComponent("friendsActivity"))
    }
}
