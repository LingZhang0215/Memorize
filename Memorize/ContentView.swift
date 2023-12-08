//
//  ContentView.swift
//  Memorize
//
//  Created by Ling on 2023/12/8.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        ZStack{
            if isFaceUp{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 20).strokeBorder(lineWidth: 2)
                
            }else{
                RoundedRectangle(cornerRadius: 20)
            }
        }
    }
}
