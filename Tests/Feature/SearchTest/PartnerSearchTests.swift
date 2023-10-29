//
//  File.swift
//  
//
//  Created by 濵田　悠樹 on 2023/10/29.
//

import XCTest
import ComposableArchitecture
import User

@testable import Search

@MainActor
final class UserInfoTest: XCTestCase {

    // MARK: - Stub

    private let user = User(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")

    // MARK: - Tests

    func test_onAppear_myInfoを正常に取得できる() async {
        let testStore = TestStore(
            initialState: PartnerSearchStore.State()
        ) {
            PartnerSearchStore()
        } withDependencies: {
            $0.userRequestClient.fetch = { id in
                return self.user
            }
        }

        await testStore.send(.onAppear)
        await testStore.receive(.setMyInfo(user)) {
            $0.myInfo = self.user
        }
    }

    func test_search_Usersを正常に取得できる() async {
        let testStore = TestStore(
            initialState: PartnerSearchStore.State()
        ) {
            PartnerSearchStore()
        } withDependencies: {
            $0.userRequestClient.fetchWithName = { name in
                return [self.user]
            }
        }

        await testStore.send(.search(""))
        await testStore.receive(.setUsers([self.user])) {
            $0.users = [self.user]
        }
    }
}
