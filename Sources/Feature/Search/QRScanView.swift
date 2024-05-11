//
//  QRScanView.swift
//
//
//  Created by 濵田　悠樹 on 2024/05/11.
//

import CodeScanner
import SwiftUI
import User

public struct QRScanView: View {
    private let user: User = .stub()

    public init() {}

    public var body: some View {
        ZStack {
            CodeScannerView(codeTypes: [.qr]) { res in
                if case let .success(res) = res {
                    print(res.string)
                }
            }

            HStack {
                Button(action: {
                    print("tached my qr button")
                }) {
                    Text("マイQRコード")
                        .foregroundStyle(.white)
                        .padding(30)
                        .background(.gray)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 1))
                        .cornerRadius(20)
                }

                Button(action: {
                    print("tached partner search button")
                }) {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .contentShape(Rectangle())  // systemName使ったimageのタップを可能にする
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QRScanView()
}
