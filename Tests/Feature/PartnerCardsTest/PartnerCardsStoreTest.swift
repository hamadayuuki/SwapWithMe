//
//  PartnerCardsStoreTest.swift
//  
//
//  Created by 濵田　悠樹 on 2024/04/28.
//

import XCTest
import ComposableArchitecture

@testable import Relationship
@testable import User
@testable import PartnerCardsStore

@MainActor
final class PartnerCardsStoreTest: XCTestCase {

    // MARK: - Stub

    private let following: User = .stub()
    private let myID = ""

    // following 3人
    private var relationship: Relationship = .init(
        followersId: [],
        followingsId: ["", "", ""],
        createdAt: Relationship.stub().createdAt,
        updateAt: Relationship.stub().updateAt
    )
    private let followingsID: [String] = ["", "", ""]
    private let followings: [User] = [.stub(), .stub(), .stub()]

    // following 0人
    private var relationshipFollowingZero: Relationship = .init(
        followersId: [],
        followingsId: [],
        createdAt: Relationship.stub().createdAt,
        updateAt: Relationship.stub().updateAt
    )
    private let followingsIDZero: [String] = []
    private let followingZero: [User] = []

    // MARK: - Tests

    func test_画面を開きフォロー一覧を正常に取得できる() async {
        let testStore = TestStore(
            initialState: PartnerCardsStore.State()
        ) {
            PartnerCardsStore()
        } withDependencies: {
            $0.relationshipRequest.fetch = { id in
                return await self.relationship
            }
            $0.userRequestClient.fetch = { followingId in
                return self.following
            }
        }

        await testStore.send(.onAppear(myID))
        await testStore.receive(.fetchRelationshipSuccessed(followingsID))
        await testStore.receive(.fetchFollowsSuccessed(followings)) { state in
            state.followings = self.followings
            state.willLoadFollows = false
        }
    }

    func test_画面を開きフォロー0人を正常に取得できる() async {
        let testStore = TestStore(
            initialState: PartnerCardsStore.State()
        ) {
            PartnerCardsStore()
        } withDependencies: {
            $0.relationshipRequest.fetch = { id in
                return await self.relationshipFollowingZero
            }
            $0.userRequestClient.fetch = { followingId in
                return self.following
            }
        }

        await testStore.send(.onAppear(myID))
        await testStore.receive(.fetchRelationshipSuccessed([]))
        await testStore.receive(.fetchFollowsSuccessed(followingZero)) { state in
            state.followings = self.followingZero
            state.willLoadFollows = false
        }
    }

    func test_カードをタップ後画面遷移する() async {
        let testStore = TestStore(
            initialState: PartnerCardsStore.State()
        ) {
            PartnerCardsStore()
        }

        await testStore.send(.tappedPartnerCard(self.following)) { state in
            state.tappedPartner = self.following
            state.isTransQuestionListView = true
        }
    }
}
