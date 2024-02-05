//
//  PhoneNumberAuthView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/08.
//

import ComposableArchitecture
import PopupView
import SignUpStore
import SwiftUI
import ViewComponents

public struct PhoneNumberAuthView: View {
    let store: StoreOf<PhoneNumberAuth>

    @State private var phoneNumber = ""

    private var isButtonEnable: Bool {
        if phoneNumber.count == 11 {
            return true
        }
        return false
    }
    private var transButtonBackground: Color {
        if isButtonEnable {
            return Color.green
        }
        return Color.gray.opacity(0.5)
    }

    public init(store: StoreOf<PhoneNumberAuth>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 18) {
                VStack(alignment: .leading, spacing: 18) {
                    Text("電話番号を使用して登録")
                        .font(.system(size: 24, weight: .bold, design: .rounded))

                    Text("間違った電話番号を登録すると、メッセージが届かずユーザー登録できません。")
                        .font(.system(size: 12, weight: .regular, design: .rounded))

                    TextField("000-0000-0000", text: $phoneNumber)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .padding(.top, 40)
                        .keyboardType(.numberPad)

                    Divider()
                        .frame(height: 5)
                        .background(.gray)
                }

                Button(
                    action: {
                        viewStore.send(.tappedSMSButton(phoneNumber))
                    },
                    label: {
                        Text("次へ")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(transButtonBackground)
                            .cornerRadius(10)
                    }
                )
                .padding(.top, 40)
                .disabled(!isButtonEnable)

                NavigationLink(
                    destination: ConfirmVerificationCodeView(
                        store: Store(initialState: ConfirmVerificationCode.State()) {
                            ConfirmVerificationCode()
                        }),
                    isActive: viewStore.binding(
                        get: { $0.isShowConfirmVerificationCodeView },
                        send: .bindingIsShowConfirmVerificationCodeView(viewStore.isShowConfirmVerificationCodeView)
                    )
                ) {
                    EmptyView()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .fitToReadableContentGuide()
            .padding(.top, 60)
            .popup(
                isPresented: viewStore.binding(
                    get: { $0.isErrorBanner },
                    send: .bindingIsErrorBanner(!viewStore.isErrorBanner)  // バナーを閉じるため
                )
            ) {
                ErrorBanner(errorTitle: "電話番号の認証に失敗しました")
                    .fitToReadableContentGuide()
            } customize: {
                $0
                    .type(.floater())
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.3))
            }
            .onDisappear {
                viewStore.send(.onDisappear)
            }
        }
    }
}

struct PhoneNumberAuthView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberAuthView(
            store: Store(initialState: PhoneNumberAuth.State()) {
                PhoneNumberAuth()
            })
    }
}
