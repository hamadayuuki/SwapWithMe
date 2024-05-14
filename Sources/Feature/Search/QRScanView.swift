//
//  QRScanView.swift
//
//
//  Created by 濵田　悠樹 on 2024/05/11.
//

import CodeScanner
import ComposableArchitecture
import PopupView
import SearchStore
import SwiftUI
import User
import ViewComponents

public struct QRScanView: View {
    private let user: User = .stub()
    @State private var isNext = false
    @State private var isConfirmPopup = false
    @State private var isTransPartnerSearchView = false
    @State private var codeScannerViewID = 0

    public init() {}

    public var body: some View {
        VStack(spacing: 0) {
            // TODO: 読み取りが広角のみのため、メルカリのQRリーダーを使用する
            CodeScannerView(codeTypes: [.qr]) { res in
                if case let .success(res) = res {
                    print(res.string)
                    isConfirmPopup = true
                }
            }
            .id(codeScannerViewID)

            VStack(spacing: 48) {
                Text("QRコードをスキャンすると\n友だちを追加できます")
                    .foregroundStyle(.gray)

                Button(action: {
                    isTransPartnerSearchView = true
                }) {
                    Text("検索はこちら")
                        .foregroundStyle(.black)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 100)
                        .background(.green.opacity(0.5))
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(.green, lineWidth: 3))
                        .cornerRadius(30)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 250)
            .background(.white)

            NavigationLink(
                destination: PartnerSearchView(
                    store: Store(initialState: PartnerSearchStore.State()) {
                        PartnerSearchStore()
                    }
                ),
                isActive: $isTransPartnerSearchView
            ) {
                EmptyView()
            }
        }
        .popup(
            isPresented: $isConfirmPopup
        ) {
            ConfirmCard(
                title: "ユーザーが見つかりました", description: "ユーザー1", isNext: $isNext,
                onClose: {
                    isConfirmPopup = false
                    codeScannerViewID += 1
                }
            )
        } customize: {
            $0
                .type(.default)
                .animation(.easeOut(duration: 0.5))
                .closeOnTap(false)
                .dragToDismiss(false)
                .backgroundColor(.black.opacity(0.3))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QRScanView()
}
