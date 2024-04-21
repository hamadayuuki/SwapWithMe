//
//  MyProfileView.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/08.
//

import ComposableArchitecture
import MyProfileStore
import ReadabilityModifier
import SwiftUI
import User
import ViewComponents

public struct MyProfileView: View {
    @State private var showsMyProfileEditView = false

    let store: StoreOf<MyProfileStore>

    public init(store: StoreOf<MyProfileStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(spacing: 24) {
                    // アイコン
                    Image("hotta")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75).stroke(Color.black, lineWidth: 4)
                        )

                    // ユーザー情報
                    VStack(spacing: 12) {
                        Text("@hotta_mayu")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Text("hello, my name is hotta mayu")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundStyle(.gray)
                    }

                    /*
                    // SNSアイコン
                    HStack(spacing: 16) {
                        ForEach(viewStore.mySns, id: \.self) { sns in
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
                     */

                    // フォロー, フォロワー, やっほう数
                    HStack(spacing: 24) {
                        ForEach(viewStore.relationStatus, id: \.self) { status in
                            VStack(spacing: 4) {
                                Text("\(status.num)")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                Text(status.title)
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                            }
                            if status == .follower(status.num) || status == .following(status.num) {
                                Divider()
                            }
                        }
                    }
                    .frame(maxHeight: 50)

                    VStack(spacing: 12) {
                        Text("最近交換したユーザー")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                CardView(user: User.stub())
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 48)
                }
            }
            .fitToReadableContentGuide()
            .onAppear {
                viewStore.send(.onAppear)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showsMyProfileEditView = true
                    }) {
                        Image(systemName: "gearshape")
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .sheet(isPresented: $showsMyProfileEditView) {
                EditMyProfileView()
            }
        }
    }
}

#Preview {
    MyProfileView(
        store: Store(initialState: MyProfileStore.State()) {
            MyProfileStore()
        }
    )
}
