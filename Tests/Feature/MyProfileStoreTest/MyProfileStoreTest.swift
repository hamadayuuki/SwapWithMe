//
//  MyProfileStoreTest.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import ComposableArchitecture
import XCTest

@testable import MyProfileStore
@testable import Relationship

@MainActor
final class MyProfileStoreTest: XCTestCase {

    // MARK: - Stub

    private let relationship = Relationship.stub()
    private struct ErrorResult: Error, Equatable {}

    // MARK: - Test

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
                SNS.other("BeReal."),
            ]
        }
        await testStore.receive(.fetchtRelationResponse(.success(relationship))) {
            $0.relationStatus = [
                RelationStatus.follower(self.relationship.followersId.count),
                RelationStatus.following(self.relationship.followingsId.count),
                RelationStatus.yahhos(500),
            ]
        }
    }

    func test_onAppear時にデータ取得に失敗した() async {
        let testStore = TestStore(
            initialState: MyProfileStore.State()
        ) {
            MyProfileStore()
        } withDependencies: {
            $0.relationshipRequest.fetch = { uid in
                throw ErrorResult()
            }
        }

        await testStore.send(.onAppear) {
            // TODO: 動的にした場合はテストを変える必要あり
            $0.mySns = [
                SNS.twitter,
                SNS.instagram,
                SNS.line,
                SNS.other("BeReal."),
            ]
        }
        await testStore.receive(.fetchtRelationResponse(.failure(ErrorResult()))) {
            $0.errorMessage = "データの取得に失敗しました"
        }
    }
}
