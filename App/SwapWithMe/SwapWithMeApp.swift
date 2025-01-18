//
//  SwapWithMeApp.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/06/25.
//

import Alamofire
import Cache
import ComposableArchitecture
import FirebaseAuth
import FirebaseCore
import FirebaseMessaging
import Home
import MyProfile
import PartnerCards
import PartnerCardsStore
import SignUp
import SwiftUI
import Tab
import UserInfo
import UserNotifications

@main
struct SwapWithMeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            //            FirstView()
            //                .environment(\.viewBuilding, AppViewBuilding())  // DIを使い モジュールの画面遷移を上書き(モジュール内から画面遷移できるようになる)

            ZStack {
                Button(action: {
                    let fcmToken = "e5RzqRyTZ0ekm0qkefjCmA:APA91bE_qgtm2p_INWfH2XCusKmfB3cg0kv8_2r5UxgtXK_NKu3tORB8aA90XPWo2lparlR4vf2xRmRTNWvfuYya-Dxsn8E5itvvGI5L3IN6tU7BqoR6a8NFWfQ50rhCNddcbXeNvvBI"
                    let imageURL = "https://firebasestorage.googleapis.com/v0/b/swapwithme-51570.appspot.com/o/Users%2Ficon%2Ficon-square.png?alt=media&token=25639758-efed-45e8-97f4-c7157bfa401d"
                    Task {
                        try await PushNotification().post(fcmToken: fcmToken, title: "タイトル", body: "テキストが入ります", imageURL: imageURL)
                    }
                }) {
                    Text("FCM!!!")
                }
            }
            //            NavigationView {
            //                PartnerCardsView(
            //                    store: Store(initialState: PartnerCardsStore.State()) {
            //                        PartnerCardsStore()
            //                    }
            //                )
            //            }
            //            NavigationView {
            //                UserBasicInfoView(
            //                    store: Store(initialState: UserBasicInfoStore.State()) {
            //                        UserBasicInfoStore()
            //                    })
            //            }
            //            SelectSignUpMethodView()

            //            NavigationView {
            //                SelectSignUpMethodView()
            //            }
        }
    }
}

struct PushNotificationResponse: Codable {
    let id: Int
    let result: String
}

final class PushNotification {

    // POST
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

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // TabView
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()

        // MARK: Firebase

        FirebaseApp.configure()

        // MARK: FCM

        // Setting Up Cloud Messaging
        Messaging.messaging().delegate = self

        // Setting Up Nortifications
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        return true
    }

    /// 電話番号認証
    /// サイレントプッシュ通知を受け取る
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(.noData)
            return
        }
    }

    // In order to receive notifications you need implement thesese methods
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("deviceToken: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
}

// MARK: FCM

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        guard let fcmToken = fcmToken else { return }

        let userDefaultClient: UserDefaultsClientProtocol = UserDefaultsClient()
        Task {
            await userDefaultClient.setString(fcmToken, "fcmToken")
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("MessageID: \(messageID)")
        }

        print(userInfo)
        completionHandler([[.banner, .badge, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("MessageID: \(messageID)")
        }

        print(userInfo)
        completionHandler()
    }
}
