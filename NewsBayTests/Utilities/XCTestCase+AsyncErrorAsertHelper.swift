//
//  XCTestCase+AsyncErrorAsertHelper.swift
//  NewsBayTests
//
//  Created by Pankaja Wijesena.
//

import XCTest

extension XCTestCase {
    func XCTAssertThrowsErrorAsync<T>(
        _ expression: @autoclosure @escaping () async throws -> T,
        _ message: @autoclosure @escaping () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail("Expected error but succeeded. \(message())", file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}
