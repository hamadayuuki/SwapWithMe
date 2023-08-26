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

@testable import UserInfo

@MainActor
final class UserInfoTest: XCTestCase {
    func test_hoge() async {
        print(#function)
        XCTAssertEqual(1, 1)
    }
}
