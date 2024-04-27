//
//  PartnerCardsStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/07.
//

import ComposableArchitecture
import Dependencies
import FirebaseFirestore  // Timestamp()
import Relationship
import Request
import SwiftUI
import User

public struct PartnerCardsStore: Reducer {
    public struct State: Equatable {
        public init() {}

        public var followings: [User] = []
        public var tappedPartner: User? = nil
        public var willLoadFollows = true  // onAppearで無駄なfetchを避けるためのフラグ
        @BindingState public var isTransQuestionListView = false
        @BindingState public var isTransMyProfileView = false
    }

    public enum Action: Equatable, BindableAction {
        case onAppear(String)
        case fetchRelationshipSuccessed([String])
        case fetchFollowsSuccessed([User])
        case tappedPartnerCard(User)
        case binding(BindingAction<State>)
        case tappedMyProfileImage
    }

    public var body: some ReducerOf<Self> {
        @Dependency(\.relationshipRequest) var relationshipRequest
        @Dependency(\.userRequestClient) var userRequestClient

        BindingReducer()

        Reduce { state, action in
            switch action {
            case .onAppear(let myID):
                if !state.willLoadFollows {
                    return .none
                }

                return .run { send in
                    do {
                        let myRelationship: Relationship = try await relationshipRequest.fetch(id: myID)
                        await send(.fetchRelationshipSuccessed(myRelationship.followingsId))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .fetchRelationshipSuccessed(let followingsId):
                return .run { send in
                    do {
                        var follows: [User] = []
                        for followingId in followingsId {
                            let follow = try await userRequestClient.fetch(followingId)
                            follows.append(follow)
                        }
                        await send(.fetchFollowsSuccessed(follows))
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .fetchFollowsSuccessed(let follows):
                state.followings = follows
                state.willLoadFollows = false
                return .none

            case .tappedPartnerCard(let partner):
                state.tappedPartner = partner
                state.isTransQuestionListView = true
                return .none

            case .tappedMyProfileImage:
                state.isTransMyProfileView = true
                return .none

            case .binding:
                return .none
            }
        }
    }

    public init() {}
}
