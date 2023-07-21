//
//  ConfirmVerificationCodeStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/17.
//

import ComposableArchitecture
import FirebaseAuth
import Foundation

public struct ConfirmVerificationCode: ReducerProtocol {
    public struct State: Equatable {
        var verificationID = ""
        var isShowUserSettingView = false
        var isErrorBanner = false
    }

    public enum Action: Equatable {
        case initVerificationID
        case tappedAuthButton(String)
        case authSuccess
        case authFailure
        case bindingIsShowUserSettingView(Bool)
        case bindingIsErrorBanner(Bool)
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
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