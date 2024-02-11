//
//  MyProfileStoreTest.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import XCTest
import ComposableArchitecture

@testable import Relationship
@testable import MyProfileStore

@MainActor
final class MyProfileStoreTest: XCTestCase {
    private let relationship = Relationship.stub()

    func test_onAppear時に正常にデータが取得され格納できるか() async {
        let testStore = TestStore(
            initialState: MyProfileStore.State()
        ) {
            MyProfileStore()
        } withDependencies: {
            $0.relationshipRequest.fetch = { uid in
                return self.relationship
            }
        }

        await testStore.send(.onAppear) {
            // TODO: 動的にした場合はテストを変える必要あり
            $0.mySns = [
                SNS.twitter,
                SNS.instagram,
                SNS.line,
                SNS.other("BeReal.")
            ]
        }
        await testStore.receive(.setRelationStatus(relationship)) {
            $0.relationStatus = [
                RelationStatus.follower(self.relationship.followersId.count),
                RelationStatus.following(self.relationship.followingsId.count),
                RelationStatus.yahhos(500)
            ]
        }
    }

    // TODO: - エラーハンドリング実装後、エラーのテストを実装
}
