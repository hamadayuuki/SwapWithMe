//
//  SwapWithMeApp.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/06/25.
//

import SignUp
import SwiftUI
import FirebaseCore

@main
struct SwapWithMeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SignUpView()
        }
    }
}

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
