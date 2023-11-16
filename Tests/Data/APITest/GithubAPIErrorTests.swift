//
//  GithubAPIErrorTests.swift
//  
//
//  Created by 濵田　悠樹 on 2023/11/15.
//

import XCTest
import Error

final class GithubAPIErrorTests: XCTestCase {
    func test_GithubAPIのレスポンスを正常にデコード() throws {
        let decoder = JSONDecoder()
        let data = GithubAPIError.stubJSON.data(using: .utf8)!
        let error = try decoder.decode(GithubAPIError.self, from: data)
        let firstError = error.errors.first

        XCTAssertEqual(error.message, "Validation Failed")
        XCTAssertEqual(firstError?.resource, "Search")
        XCTAssertEqual(firstError?.field, "q")
        XCTAssertEqual(firstError?.code, "missing")
    }
}
