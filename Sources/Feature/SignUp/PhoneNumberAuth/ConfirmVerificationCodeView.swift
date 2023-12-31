//
//  ConfirmVerificationCodeView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/10.
//

import ComposableArchitecture
import FirebaseAuth
import PopupView
import SwiftUI
import ViewComponents

struct ConfirmVerificationCodeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var verificationCode = ""

    let store: StoreOf<ConfirmVerificationCode>

    private var isButtonEnable: Bool {
        if verificationCode.count == 6 {
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

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 18) {
                VStack(alignment: .leading, spacing: 18) {
                    Text("SMSで届いた6桁の数字を入力")
                        .font(.system(size: 24, weight: .bold, design: .rounded))

                    TextField("123456", text: $verificationCode)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .padding(.top, 40)
                        .keyboardType(.numberPad)

                    Divider()
                        .frame(height: 5)
                        .background(.gray)
                }

                Button(
                    action: {
                        viewStore.send(.tappedAuthButton(verificationCode))
                    },
                    label: {
                        Text("登録")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(transButtonBackground)
                            .cornerRadius(10)
                    }
                )
                .padding(.top, 40)
                .disabled(!isButtonEnable)

                // TODO: 遷移先のViewを変更
                NavigationLink(
                    destination: SelectSignUpMethodView(),
                    isActive: viewStore.binding(
                        get: { $0.isShowUserSettingView },
                        send: .bindingIsErrorBanner(viewStore.isShowUserSettingView))
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
                    send: .bindingIsErrorBanner(!viewStore.isErrorBanner))
            ) {
                ErrorBanner(errorTitle: "認証コードが正しくありません")
                    .fitToReadableContentGuide()
                    .onDisappear {
                        presentationMode.wrappedValue.dismiss()
                    }
            } customize: {
                $0
                    .type(.floater())
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.3))
            }
            .onAppear {
                viewStore.send(.initVerificationID)
            }
        }
    }
}

struct ConfirmVerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: ConfirmVerificationCode.State()) {
            ConfirmVerificationCode()
        }
        ConfirmVerificationCodeView(store: store)
    }
}
