//
//  UserBasicInfoView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/21.
//

import ReadabilityModifier
import SwiftUI

public struct UserBasicInfoView: View {
    @State private var selectedValue = 0
    @State var selectAge: String = "20"

    public init() {}

    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("基本情報")
                .font(.system(size: 24, weight: .bold, design: .rounded))

            Text("ユーザー情報を登録するための質問です。気軽に回答してください。")
                .font(.system(size: 12, weight: .regular, design: .rounded))

            // TODO: 質問の内容を変更
            ForEach(0..<5) { i in
                VStack(spacing: 4) {
                    HStack {
                        Text("年齢")
                        CustomPicker(selectionValue: $selectAge)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    Divider()
                        .frame(height: 1)
                        .background(.gray)
                }
            }
        }
        .fitToReadableContentGuide()
        .onChange(of: selectAge) { value in
            print(value)
        }
    }
}

struct CustomPicker: View {
    @Binding var selectionValue: String

    var body: some View {
        VStack {
            HStack {
                //ユーザを入力するピッカー
                Picker("20", selection: $selectionValue) {
                    ForEach(0..<80) { age in
                        Text("\(age)")
                            .tag("\(age)")
                    }
                }
            }
        }
    }
}

struct UserBasicInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserBasicInfoView()
    }
}
