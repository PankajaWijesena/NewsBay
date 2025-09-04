//
//  NetworkServicing.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//


import Foundation

protocol NetworkServicing {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?,
        queryItems: [String: String]?
    ) async throws -> T
}
