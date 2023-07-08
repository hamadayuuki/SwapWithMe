//
//  SignUpView.swift
//  
//
//  Created by 濵田　悠樹 on 2023/07/06.
//

import ReadabilityModifier
import SwiftUI

public struct SignUpView: View {
    public init() {}

    public var body: some View {
        VStack(spacing: 24) {
            Button(action: {
                
            }, label: {
                ZStack {
                    Text("電話番号で続ける")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Image(systemName: "phone.bubble.left.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: 300 - 40, alignment: .leading)
                }
                .frame(width: 300, height: 50)
                .background(.green)
                .cornerRadius(100)
            })
            
            Button(action: {
                
            }, label: {
                ZStack {
                    Text("Appleで続ける")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Image(systemName: "apple.logo")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: 300 - 50, alignment: .leading)
                }
                .frame(width: 300, height: 50)
                .background(.black)
                .cornerRadius(100)
            })
            
            Button(action: {
                
            }, label: {
                ZStack {
                    Text("Googleで続ける")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    Image(systemName: "globe.central.south.asia")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                        .frame(width: 300 - 50, alignment: .leading)
                }
                .frame(width: 300, height: 50)
                .background(.gray.opacity(0.3))
                .cornerRadius(100)
            })
        }
        .fitToReadableContentGuide(type: .width)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
