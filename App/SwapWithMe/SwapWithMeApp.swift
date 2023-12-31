//
//  SwapWithMeApp.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/06/25.
//

import ComposableArchitecture
import FirebaseAuth
import FirebaseCore
import Home
import SignUp
import SwiftUI
import Tab
import UserInfo

@main
struct SwapWithMeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            FirstView()
                .environment(\.viewBuilding, AppViewBuilding())  // DIを使い モジュールの画面遷移を上書き(モジュール内から画面遷移できるようになる)
            //            AppTabView()
            //            NavigationView {
            //                UserBasicInfoView(
            //                    store: Store(initialState: UserBasicInfoStore.State()) {
            //                        UserBasicInfoStore()
            //                    })
            //            }
            //            SelectSignUpMethodView()
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
