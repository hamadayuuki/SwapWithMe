//
//  ContenView.swift
//  
//
//  Created by 濵田　悠樹 on 2023/07/04.
//

import SwiftUI

// モジュール外からアクセスするために public な修飾子を付与する
public struct ContentView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}
