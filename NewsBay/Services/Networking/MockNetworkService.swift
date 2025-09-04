//
//  NetworkService.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

final class MockNetworkService: NetworkServicing {
    var response: Any?
    var error: NetworkError?
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: [String : String]?,
        body: Data?,
        queryItems: [String : String]?
    ) async throws -> T {
        if let error {
            throw error
        }
        guard let result = response as? T else {
            throw NetworkError.decodingFailed(NSError(domain: "Mock", code: 1))
        }
        return result
    }
}
