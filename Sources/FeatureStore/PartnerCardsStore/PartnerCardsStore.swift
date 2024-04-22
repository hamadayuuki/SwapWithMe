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

        public var follows: [User] = []
        public var tappedPartner: User? = nil
        @BindingState public var isTransQuestionListView = false
        @BindingState public var isTransMyProfileView = false
    }

    public enum Action: Equatable, BindableAction {
        case onAppear
        case tappedPartnerCard(User)
        case binding(BindingAction<State>)
        case tappedMyProfileImage
    }

    public var body: some ReducerOf<Self> {
        @Dependency(\.relationshipRequest) var relationshipRequest

        BindingReducer()

        Reduce { state, action in
            switch action {
            case .onAppear:
                state.follows = [User.stub(), User.stub(), User.stub(), User.stub()]
                return .run { _ in
                    Task {
                        do {
                            let myID = "18D93893-3CAC-41B3-82AA-3B8A3EFDEBD6"
                            let myRelationship: Relationship = try await relationshipRequest.fetch(id: myID)
                            print(myRelationship)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }

                    // set + addFollower
                    //                    Task {
                    //                        let myID = "18D93893-3CAC-41B3-82AA-3B8A3EFDEBD6"
                    //                        let relationshipData: Relationship = .init(
                    //                            followersId: [
                    //                                "1BD1B743-E955-40A4-87A9-B68F4543D994",
                    //                                "1E0A092B-D6E0-4B1F-8A67-8FFB862E4597",
                    //                                "2F5DD7D6-A629-483B-960A-DF050857690E",
                    //                                "3F1BE939-9E10-4BCD-8DAA-105299D997F1",
                    //                                "80C0DFC1-8794-413B-95CA-AF57E8D4EFDA",
                    //                                "8FA167F4-E3CD-449A-92F2-7FC2CB5CB0B4",
                    //                                "97798193-E766-4470-8AE5-A318D4960982",
                    //                            ],
                    //                            followingsId: [],
                    //                            createdAt: Timestamp(),
                    //                            updateAt: Timestamp()
                    //                        )
                    //                        let insertUserID = "ABD84218-F852-42A0-AEFD-DA1624AE9E57"
                    //                        do {
                    //                            let _ = try relationshipRequest.set(myId: myID, data: relationshipData)
                    //                            let _ = try await relationshipRequest.addFollower(myId: myID, friendId: insertUserID)
                    //                        } catch {
                    //                            print(error.localizedDescription)
                    //                        }
                    //                    }
                }

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
