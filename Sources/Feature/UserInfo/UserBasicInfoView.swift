//
//  UserBasicInfoView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/21.
//

import ComposableArchitecture
import ReadabilityModifier
import SwiftUI
import User
import UserInfoStore
import ViewComponents

public struct UserBasicInfoView: View {
    var store: StoreOf<UserBasicInfoStore>

    @State var nickName: String = ""
    @State var selectAge: String = "-"
    @State var selectSex: String = "-"
    @State var selectAffiliation: String = "-"
    @State var selectDogOrCat: String = "-"
    @State var selectActivity: String = "-"
    @State var selectPersonality: String = "-"
    @State var description: String = ""

    private var sex: Sex {
        switch selectSex {
        case "男性": return .man
        case "女性": return .woman
        case "未回答": return .noGender
        default: return .noGender
        }
    }
    private var affiliation: Affiliation {
        switch selectAffiliation {
        case "中学生": return .juniorHigh
        case "高校生": return .high
        case "大学生": return .university
        case "社会人": return .society
        case "その他": return .others
        default: return .others
        }
    }
    private var animal: Animal {
        switch selectDogOrCat {
        case "🐶": return .dog
        case "😺": return .cat
        default: return .dog
        }
    }
    private var activity: Activity {
        switch selectActivity {
        case "インドア": return .indoor
        case "アウトドア": return .outdoor
        default: return .indoor
        }
    }
    private var personality: Personality {
        switch selectPersonality {
        case "人見知り": return .shy
        case "フレンドリー": return .friendly
        default: return .shy
        }
    }

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

    public init(store: StoreOf<UserBasicInfoStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 24) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("基本情報")
                            .font(.system(size: 24, weight: .bold, design: .rounded))

                        Text("ユーザー情報を登録するための質問です。気軽に回答してください。")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .padding(.bottom, 24)

                        QuestionTextField(title: "ニックネーム", placeholder: "8文字以内で入力", text: $nickName)
                        QuestionPickerView(type: .age, selectionValue: $selectAge)
                        QuestionPickerView(type: .sex, selectionValue: $selectSex)
                        QuestionPickerView(type: .affiliation, selectionValue: $selectAffiliation)
                        QuestionPickerView(type: .dogOrCat, selectionValue: $selectDogOrCat)
                        QuestionPickerView(type: .activity, selectionValue: $selectActivity)
                        QuestionPickerView(type: .personality, selectionValue: $selectPersonality)
                        QuestionTextField(title: "ひとこと", placeholder: "自由に入力", text: $description)
                    }
                }

                Button(
                    action: {
                        // TODO: 入力した情報をUserの項目に合わせて変換する
                        let user = User.init(iconURL: nil, name: nickName, age: Int(selectAge)!, sex: self.sex, affiliation: self.affiliation, animal: self.animal, activity: self.activity, personality: self.personality, description: description)
                        viewStore.send(.tappedButton(user))
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
                    destination: SelectUserCardImageView(
                        store: Store(initialState: SelectUserCardImageStore.State()) {
                            SelectUserCardImageStore()
                        },
                        user: viewStore.user
                    ),
                    isActive: viewStore.binding(
                        get: { $0.tappedTransButton },
                        send: .bindingTappedTransButton(viewStore.tappedTransButton)
                    )
                ) {
                    EmptyView()
                }
            }
            .fitToReadableContentGuide()
            .padding(.top, 24)
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
        UserBasicInfoView(
            store: Store(initialState: UserBasicInfoStore.State()) {
                UserBasicInfoStore()
            })
    }
}
