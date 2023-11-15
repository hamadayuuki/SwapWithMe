//
//  GithubAPIError.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/15.
//

// APIのエラーレスポンスによって都度作成する必要ある

import Foundation

public struct GithubAPIError: Decodable {
    public var message: String
    public var errors: [Error]

    public struct Error: Decodable {
        public var resource: String
        public var field: String
        public var code: String
    }
}

// MARK: - extension

extension GithubAPIError {
    /// テスト用の JSONデータ
    /// GithubAPIのレスポンスを想定
    static public var stubJSON: String {
        return """
            {
                "message": "Validation Failed",
                "errors": [
                    {
                        "resource": "Search",
                        "field": "q",
                        "code": "missing",
                    }
                ]

            }
            """
    }
}
