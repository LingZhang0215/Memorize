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
            //let emojis: Array<String> = ["👻","💩","🤡","😈"]
            let emojis = ["👻","💩","🤡","😈"]
            ForEach(emojis.indices, id:\.self){index in
                CardView(emoji: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    let emoji: String
    @State var isFaceUp = true
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 20)
            if isFaceUp{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(emoji)
            }else{
                base
            }
        }
        .onTapGesture {
            print("tapped")
            //isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
    }
}
