//
//  PushNotification.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2025/01/18.
//

import Alamofire
import FirebaseMessaging

public struct PushNotificationResponse: Codable, Sendable {
    let id: Int
    let result: String
}

public final class PushNotification {
    public init() {}

    /// FCM用のサーバーを立ち上げてから呼び出す
    ///
    ///```
    ///let fcmToken = "e5RzqRyTZ0ekm0qkefjCmA:APA91bE_qgtm2p_INWfH2XCusKmfB3cg0kv8_2r5UxgtXK_NKu3tORB8aA90XPWo2lparlR4vf2xRmRTNWvfuYya-Dxsn8E5itvvGI5L3IN6tU7BqoR6a8NFWfQ50rhCNddcbXeNvvBI"
    ///let imageURL = "https://firebasestorage.googleapis.com/v0/b/swapwithme-51570.appspot.com/o/Users%2Ficon%2Ficon-square.png?alt=media&token=25639758-efed-45e8-97f4-c7157bfa401d"
    ///Task {
    ///    try await PushNotification().post(fcmToken: fcmToken, title: "タイトル", body: "テキストが入ります", imageURL: imageURL)
    ///}
    ///```
    public func post(fcmToken: String, title: String, body: String, imageURL: String) async throws -> PushNotificationResponse {
        /// FCM用APIのURL
        let url = "https://fcm-push-notification-api.onrender.com/pushNotification/"
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        let parameters: [String: Any] = [
            "user_fcm_token": fcmToken,
            "title": title,
            "body": body,
            "imageURL": imageURL,
        ]
        return try await AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .serializingDecodable(PushNotificationResponse.self)
            .value
    }
}
