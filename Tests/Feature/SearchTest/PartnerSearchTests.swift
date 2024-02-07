//
//  PartnerSearchTests.swift
//  
//
//  Created by 濵田　悠樹 on 2023/10/29.
//

import XCTest
import ComposableArchitecture
import User

@testable import SearchStore

@MainActor
final class PartnerSearchTests: XCTestCase {

    // MARK: - Stub

    private let user = User(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")
    /// エラーを再現する
    private struct ErrorResult: Error, Equatable {}

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
        await testStore.receive(.setMyInfo(.success(user))) {
            $0.myInfo = self.user
        }
    }

    func test_onAppear_myInfo取得時にエラー発生() async {
        let testStore = TestStore(
            initialState: PartnerSearchStore.State()
        ) {
            PartnerSearchStore()
        } withDependencies: {
            $0.userRequestClient.fetch = { id in
                throw ErrorResult()
            }
        }

        await testStore.send(.onAppear)
        await testStore.receive(.setMyInfo(.failure(ErrorResult()))) {
            $0.showsError = true
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
        await testStore.receive(.setUsers(.success([self.user]))) {
            $0.users = [self.user]
        }
    }

    func test_onAppear_Users取得時にエラー発生() async {
        let testStore = TestStore(
            initialState: PartnerSearchStore.State()
        ) {
            PartnerSearchStore()
        } withDependencies: {
            $0.userRequestClient.fetchWithName = { name in
                throw ErrorResult()
            }
        }

        await testStore.send(.search(""))
        await testStore.receive(.setUsers(.failure(ErrorResult()))) {
            $0.showsError = true
        }
    }
}
