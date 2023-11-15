//
//  GithubAPIRequest.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/15.
//

import Foundation

// TODO: - 別ファイルにて定義
public struct SearchRepositoryResponse: Decodable {
    let totalCount: Int
}

public final class GithubAPIRequest {

    // MARK: - SearchRepository

    /// let request = GIthubAPI.SearchRepository(searchWord: "swift")
    public struct SearchRepository: APIRequest {
        let searchWord: String

        public typealias Response = SearchRepositoryResponse

        public var baseURL: URL {
            guard let baseURL = URL(string: "https://api.github.com") else { fatalError("error baseURL") }
            return baseURL
        }

        public var path: String {
            return "/search/repositories"
        }

        public var method: HTTPMethod {
            return .get
        }

        public var body: Encodable? {
            return nil
        }

        public var urlQueryItem: URLQueryItem {
            return URLQueryItem(name: "q", value: searchWord)
        }
    }
}
