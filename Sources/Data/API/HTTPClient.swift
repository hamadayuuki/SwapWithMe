//
//  HTTPClient.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/16.
//

import Error
import Foundation

public protocol HTTPClientProtocol {
    func request<D: Decodable>(apiRequest: any APIRequest) async throws -> Result<D, HTTPClientError>
}

public class HTTPClient: HTTPClientProtocol {
    private static var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase  // total_count -> totalCount
        return jsonDecoder
    }

    public init() {}

    ///Task {
    ///    let response: Result<SearchRepositoryResponse, HTTPClientError> = try await httpClient.request(apiRequest: apiRequest)
    ///}
    public func request<D: Decodable>(apiRequest: any APIRequest) async throws -> Result<D, HTTPClientError> {
        let request = apiRequest.buildURLRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpStatus = response as? HTTPURLResponse else {
            return .failure(.responseError)
        }

        switch httpStatus.statusCode {
        case 200..<300:
            do {
                let decodedData = try HTTPClient.decoder.decode(D.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.decodeError)
            }
        case 400..<600:
            let error = errorHandling(statusCode: httpStatus.statusCode)
            return .failure(error)
        default:
            return .failure(.unknownError)
        }
    }
}

// MARK: - extension

extension HTTPClient {
    /// 400, 500番台のエラーハンドリング
    public func errorHandling(statusCode: Int) -> HTTPClientError {
        switch statusCode {
        // 4xx クライアントエラー
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 405:
            return .methodNotAllowed
        case 408:
            return .requestTimeout
        case 409:
            return .conflict
        case 429:
            return .tooManyRequests
        case 400...499:
            return .clientError(statusCode)
        // 5xx サーバーエラー
        case 500:
            return .internalServerError
        case 501:
            return .notImplemented
        case 502:
            return .badGateway
        case 503:
            return .serviceUnavailable
        case 504:
            return .gatewayTimeout
        case 500...599:
            return .serverError(statusCode)
        default:
            return .unknownError
        }
    }
}
