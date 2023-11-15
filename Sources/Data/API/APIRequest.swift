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
    var path: String { get }
    var method: HTTPMethod { get }
    var urlQueryItem: URLQueryItem { get }   // https://〜?hoge=1&hage=2 のクエリ
    var body: Encodable? { get }
}

// MARK: - extension

public extension APIRequest {

}
