//
//  Constant.swift
//  NewsBay
//
//  Created by Pankaja Wijesena.
//

import Foundation

enum Constant {
    enum API {
        static let baseURL: String = Bundle.main.apiBaseURL
        static let paginationLimit: Int = Bundle.main.paginationLimit
        static let debounceDelay: Int = Bundle.main.searchDebounceDelay
    }
}

fileprivate extension Bundle {
    var apiBaseURL: String {
        guard
            let url = object(forInfoDictionaryKey: "API_BASE_URL") as? String
        else {
            fatalError("API_BASE_URL not found in Info.plist")
        }
        return url
    }
    var paginationLimit: Int {
        guard
            let value = object(forInfoDictionaryKey: "PAGINATION_LIMIT") as? String,
            let limit = Int(value)
        else {
            fatalError("PAGINATION_LIMIT not found in Info.plist")
        }
        return limit
    }
    var searchDebounceDelay: Int {
        guard
            let value = object(forInfoDictionaryKey: "SEARCH_DEBOUNCE_DELAY") as? String,
            let delay = Int(value)
        else {
            fatalError("SEARCH_DEBOUNCE_DELAY not found in Info.plist")
        }
        return delay
    }
}
