//
//  APIRequest.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/15.
//

import Foundation

public protocol APIRequest {
    associatedtype Response: Decodable

    // 外部から変更されることはないため getter
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var urlQueryItem: URLQueryItem { get }  // https://〜?hoge=1&hage=2 のクエリ
    var body: Encodable? { get }
}

// MARK: - extension

extension APIRequest {
    public func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)

        switch method {
        case .get:
            components?.queryItems = [urlQueryItem]
        case .post:
            // TODO: header や body にPOST時に必要なデータを追加
            break
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
