//
//  UserInfoTest.swift
//  
//
//  Created by 濵田　悠樹 on 2023/08/26.
//

/*
Test Plan の作成
 SPMマルチモジュール構成を採用するとモジュールとしてテストを書くため、TestPlan を作る必要がある
 1: Product > Test Plan > New Test Plan ...
 2: 作成された Test Plan へ移動
 3 : 画面左下の + を押し > UserInfoTest を追加
 */

import XCTest
import ComposableArchitecture
import User
import UserInfoStore

@testable import UserInfo

@MainActor
final class UserInfoTest: XCTestCase {

    // MARK: - Stub

    let user = User.init(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .others, animal: .dog, activity: .outdoor, personality: .shy, description: "")

    // MARK: - Test

    /// Stateの変更に関して不具合がないかを確認するだけのテスト
    func test_ユーザー情報が入力され_Stateに反映される() async {
        /// Given (前提条件)：操作を実行する前の状態
        let testStore = TestStore(
            initialState: UserBasicInfoStore.State()
        ) {
            UserBasicInfoStore()
        }

        /// When (操作): メソッドの呼び出し
        await testStore.send(.tappedButton(user)) {
            /// Then (結果) : 操作した結果
            $0.user = self.user
            $0.tappedTransButton = true
        }
    }

    func test_画面遷移ボタンが押され_Stateに反映される() async {
        /// Given (前提条件)
        let testStore = TestStore(
            initialState: UserBasicInfoStore.State()
        ) {
            UserBasicInfoStore()
        }

        /// When (操作)
        await testStore.send(.bindingTappedTransButton(true)) {
            /// Then (結果)
            $0.tappedTransButton = true
        }
    }

    func test_ユーザー情報入力が完了し画面遷移ボタンが押された時_Stateに反映される() async {
        /// Given (前提条件)
        let testStore = TestStore(
            initialState: UserBasicInfoStore.State()
        ) {
            UserBasicInfoStore()
        }

        /// When (操作)
        await testStore.send(.tappedButton(user)) {
            $0.user = self.user
            $0.tappedTransButton = true
        }
        // State に変化がない場合はクロージャでの確認を省略可能
        await testStore.send(.bindingTappedTransButton(testStore.state.tappedTransButton))
    }
}
