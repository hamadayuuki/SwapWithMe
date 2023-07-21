//
//  UserBasicInfoView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/21.
//

import ReadabilityModifier
import SwiftUI

public struct UserBasicInfoView: View {
    @State var nickName: String = ""
    @State var selectAge: String = "-"
    @State var selectSex: String = "-"
    @State var selectAffiliation: String = "-"
    @State var selectDogOrCat: String = "-"
    @State var selectActivity: String = "-"
    @State var selectPersonality: String = "-"

    private var isButtonEnable: Bool {
        if !nickName.isEmpty && nickName.count <= 8 && selectAge != "-" && selectSex != "-" && selectAffiliation != "-" && selectDogOrCat != "-" && selectActivity != "-" && selectPersonality != "-" {
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

    public init() {}

    public var body: some View {
        VStack(spacing: 24) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("基本情報")
                        .font(.system(size: 24, weight: .bold, design: .rounded))

                    Text("ユーザー情報を登録するための質問です。気軽に回答してください。")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .padding(.bottom, 24)

                    QuestionTextFieldView(nickName: $nickName)
                    QuestionPickerView(type: .age, selectionValue: $selectAge)
                    QuestionPickerView(type: .sex, selectionValue: $selectSex)
                    QuestionPickerView(type: .affiliation, selectionValue: $selectAffiliation)
                    QuestionPickerView(type: .dogOrCat, selectionValue: $selectDogOrCat)
                    QuestionPickerView(type: .activity, selectionValue: $selectActivity)
                    QuestionPickerView(type: .personality, selectionValue: $selectPersonality)
                }
            }

            Button(
                action: {
                    print("Tapped user basic info button")
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
            .disabled(true)
        }

        .fitToReadableContentGuide()
        .padding(.top, 24)
    }

    private func QuestionTextFieldView(nickName: Binding<String>) -> some View {
        VStack(spacing: 4) {
            HStack {
                Text("ニックネーム")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                Spacer()
                TextField("8文字以内で入力", text: nickName)
                    .frame(maxWidth: 150, alignment: .trailing)
            }
            Divider()
                .frame(height: 1)
                .background(.gray)
        }
    }

    private func QuestionPickerView(type: UserBasicInfo, selectionValue: Binding<String>) -> some View {
        VStack(spacing: 4) {
            HStack {
                Text(type.question.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                CustomPicker(answers: type.answer.items, selectionValue: selectionValue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            Divider()
                .frame(height: 1)
                .background(.gray)
        }
    }
}

struct CustomPicker: View {
    var answers: [String]
    @Binding var selectionValue: String

    var body: some View {
        VStack {
            HStack {
                Picker("", selection: $selectionValue) {
                    ForEach(answers, id: \.self) { answer in
                        Text(answer)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .tag(answer)
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
