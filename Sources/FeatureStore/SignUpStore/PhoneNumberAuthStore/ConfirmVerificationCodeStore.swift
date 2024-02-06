//
//  ConfirmVerificationCodeStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/17.
//

import ComposableArchitecture
import FirebaseAuth
import Foundation

public struct ConfirmVerificationCode: Reducer {
    public struct State: Equatable {
        public var verificationID = ""
        public var isShowUserSettingView = false
        public var isErrorBanner = false

        public init() {}
    }

    public enum Action: Equatable {
        case initVerificationID
        case tappedAuthButton(String)
        case authSuccess
        case authFailure
        case bindingIsShowUserSettingView(Bool)
        case bindingIsErrorBanner(Bool)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .initVerificationID:
                if let verificationID = UserDefaults.standard.string(forKey: "verificationID") {
                    state.verificationID = verificationID
                } else {
                    state.isErrorBanner = true
                }
                return .none

            case .tappedAuthButton(let verificationCode):
                let credential = PhoneAuthProvider.provider().credential(
                    withVerificationID: state.verificationID,
                    verificationCode: verificationCode
                )

                return .run { send in
                    Auth.auth().signIn(with: credential) { authResult, error in
                        if let error = error {
                            send(.authFailure)
                        } else {
                            send(.authSuccess)
                        }
                    }
                }

            case .authSuccess:
                state.isShowUserSettingView = true
                return .none
            case .authFailure:
                state.isErrorBanner = true
                return .none

            case .bindingIsShowUserSettingView(let ver):
                state.isShowUserSettingView = ver
                return .none
            case .bindingIsErrorBanner(let ver):
                state.isErrorBanner = ver
                return .none
            }
        }
    }

    public init() {}
}
