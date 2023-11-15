//
//  HTTPClient.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/16.
//

import Error
import Foundation

public protocol HTTPClientProtocol {
    func request<D: Decodable>(apiRequest: APIRequest) async throws -> Result<D, HTTPClientError>
}

public class HTTPClient: HTTPClientProtocol {
    private static let decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }

    func request<D: Decodable>(apiRequest: APIRequest) async throws -> Result<D, HTTPClientError> {
        let request = apiRequest.buildURLRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = urlResponse as? HTTPURLResponse else {
            throw HTTPClientError.responseError
        }

        switch httpStatus.statusCode {
        case 200..<300:
            do {
                return try decoder.decode(D.self, from: data)
            } catch {
                throw HTTPClientError.decodeError
            }
        case 400..<600:
            errorHandling(statusCode: httpStatus.statusCode)
        default:
            throw HTTPClientError.unknownError
        }
    }
}

// MARK: - extension

extension HTTPClient {
    /// 400, 500番台のエラーハンドリング
    public func errorHandling(statusCode: Int) throws {
        switch statusCode {
        // 4xx クライアントエラー
        case 400:
            throw HTTPClientError.badRequest
        case 401:
            throw HTTPClientError.unauthorized
        case 403:
            throw HTTPClientError.forbidden
        case 404:
            throw HTTPClientError.notFound
        case 405:
            throw HTTPClientError.methodNotAllowed
        case 408:
            throw HTTPClientError.requestTimeout
        case 409:
            throw HTTPClientError.conflict
        case 429:
            throw HTTPClientError.tooManyRequests
        case 400...499:
            throw HTTPClientError.clientError(statusCode)
        // 5xx サーバーエラー
        case 500:
            throw HTTPClientError.internalServerError
        case 501:
            throw HTTPClientError.notImplemented
        case 502:
            throw HTTPClientError.badGateway
        case 503:
            throw HTTPClientError.serviceUnavailable
        case 504:
            throw HTTPClientError.gatewayTimeout
        case 500...599:
            throw HTTPClientError.serverError(statusCode)
        }
    }
}
