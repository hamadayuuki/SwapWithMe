//
//  RepositoryView.swift
//
//
//  Created by 濵田　悠樹 on 2023/10/30.
//

import ComposableArchitecture
import SearchStore
import SwiftUI

// MARK: - View

struct RepositoryView: View {
    // store の初期化
    let store: StoreOf<RepositoryStore>
    public init(store: StoreOf<RepositoryStore>) {
        self.store = store
    }

    var body: some View {
        // Store の呼び出しを可能にする
        // Action や State へのアクセスが可能となる
        // viewStore : let viewStore: ViewStore<RepositoryStore.State, RepositoryStore.Action>
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                // State を View へ反映させる
                Text(viewStore.ripositories[0])
            }
            .onAppear {
                // Action の発行
                viewStore.send(.onAppear)
            }
        }
    }
}

// Preview
struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        // Store を渡す必要がある
        RepositoryView(
            store: Store(initialState: RepositoryStore.State()) {
                RepositoryStore()
            }
        )
    }
}
