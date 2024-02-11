//
//  MyProfileStore.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import ComposableArchitecture
import Dependencies
import Error
import FirebaseFirestore
import FirebaseFirestoreSwift
import Relationship
import Request
import SwiftUI

public struct MyProfileStore: Reducer {
    @Dependency(\.relationshipRequest) var relationshipRequest

    public struct State: Equatable {
        public var mySns: [SNS] = []
        public var relationStatus: [RelationStatus] = [.follower(0), .following(0), .yahhos(0)]

        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case fetchtRelationResponse(TaskResult<Relationship>)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                // TODO: 動的にする, 今は表示用にデータを決めうちで定義
                // 現在はstubしているだけ
                state.mySns = [.twitter, .instagram, .line, .other("BeReal.")]
                return .run { send in
                    await send(
                        .fetchtRelationResponse(
                            TaskResult {
                                try await relationshipRequest.fetch("relationship-stub")
                            }
                        ))
                }

            case .fetchtRelationResponse(.success(let relationship)):
                state.relationStatus = [
                    .follower(relationship.followersId.count),
                    .following(relationship.followingsId.count),
                    .yahhos(500),
                ]
                return .none
            case .fetchtRelationResponse(.failure(let error as NSError)):
                if error.domain == FirestoreErrorDomain {
                    return .none
                } else {
                    return .none
                }
            }
        }
    }

    public init() {}
}
