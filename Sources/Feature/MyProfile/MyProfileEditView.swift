//
//  MyProfileEditView.swift
//
//
//  Created by 濵田　悠樹 on 2024/03/11.
//

import MyProfileStore
import SwiftUI

public struct MyProfileEditView: View {
    private var mySns: [SNS] = [.twitter, .instagram, .line, .other("BeReal.")]

    public var body: some View {
        VStack(spacing: 24) {
            // アイコン
            ZStack(alignment: .bottomTrailing) {
                Image("hotta")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
                    .overlay(
                        RoundedRectangle(cornerRadius: 75).stroke(Color.black, lineWidth: 4)
                    )

                Image(systemName: "camera.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            }

            // ユーザー情報
            VStack(spacing: 12) {
                Text("@hotta_mayu")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                Text("hello, my name is hotta mayu")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundStyle(.gray)
            }

            // SNSアイコン
            HStack(spacing: 16) {
                ForEach(mySns, id: \.self) { sns in
                    Image(sns.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 1)
                        )
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MyProfileEditView()
}
