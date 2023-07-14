//
//  ErrorBanner.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/12.
//

import SwiftUI

public struct ErrorBanner: View {
    private var errorTitle = ""

    public init(errorTitle: String) {
        self.errorTitle = errorTitle
    }

    public var body: some View {
        Text("\(errorTitle)")
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(.red.opacity(0.9))
            .cornerRadius(10.0)
    }
}

struct ErrorBanner_Previews: PreviewProvider {
    static var previews: some View {
        ErrorBanner(errorTitle: "エラーが発生しました")
    }
}
