//
//  PhoneNumberAuthStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/17.
//

import ComposableArchitecture
import FirebaseAuth
import Foundation

public struct PhoneNumberAuth: ReducerProtocol {
    public struct State: Equatable {
        var isShowConfirmVerificationCodeView = false
        var isErrorBanner = false
    }

    public enum Action: Equatable {
        case tappedSMSButton(String)
        case smsSuccessed(String)
        case smsFailured
        case bindingIsShowConfirmVerificationCodeView(Bool)
        case bindingIsErrorBanner(Bool)
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .tappedSMSButton(let phoneNumber):
            return .run { send in
                // Firebase Auth のテストデータとして私用の電話番号を設定済み
                PhoneAuthProvider.provider()
                    .verifyPhoneNumber("+81" + phoneNumber, uiDelegate: nil) { verificationID, error in
                        if let verificationID = verificationID {
                            send(.smsSuccessed(verificationID))
                        } else {
                            send(.smsFailured)
                        }
                    }
            }

        case .smsSuccessed(let verificationID):
            UserDefaults.standard.set(verificationID, forKey: "verificationID")
            state.isShowConfirmVerificationCodeView = true
            return .none

        case .smsFailured:
            state.isErrorBanner = true
            return .none

        case .bindingIsShowConfirmVerificationCodeView(let ver):
            state.isShowConfirmVerificationCodeView = ver
            return .none
        case .bindingIsErrorBanner(let ver):   // バナーを閉じる時呼ばれる
            state.isErrorBanner = ver
            return .none
        }
    }
}
