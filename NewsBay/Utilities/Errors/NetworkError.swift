//
//  NetworkError.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case apiError(_ error: Error)
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .invalidResponse:
            "Invalid response from server"
        case .statusCode(let code):
            "Unexpected status code: \(code)"
        case .apiError(let error):
            "API requrest failed: \(error)"
        case .decodingFailed(let error):
            "Decoding failed: \(error)"
        }
    }
}
