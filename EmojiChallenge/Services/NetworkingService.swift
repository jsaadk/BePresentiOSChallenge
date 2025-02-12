//
//  NetworkingService.swift
//  EmojiChallenge
//
//  Created by Jose Saad on 8/2/25.
//

import Foundation
import UIKit

protocol NetworkingService {
    func request<T: Decodable>(_ returnType: T.Type, request: URLRequest) async throws -> T
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionFailure
}

struct NetworkingServiceImpl: NetworkingService {
    private let urlSession: URLSession
    private let formatter = DateFormatter.apiFormatter
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request<T: Decodable>(_ returnType: T.Type, request: URLRequest) async throws -> T {
        let (data, response) = try await urlSession.data(for: request)
        
        try filterResponse(response: response)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        let decodedData = try decoder.decode(returnType, from: data)
        return decodedData
    }
    
    private func filterResponse(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
}
