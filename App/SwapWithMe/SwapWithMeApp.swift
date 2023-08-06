//
//  SwapWithMeApp.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/06/25.
//

import FirebaseAuth
import FirebaseCore
import SignUp
import SwiftUI

@main
struct SwapWithMeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SelectSignUpMethodView()
        }
    }
}

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // TabView
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = false

        // Firebase
        FirebaseApp.configure()

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
}
