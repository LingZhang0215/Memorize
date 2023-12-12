//
//  ContentView.swift
//  Memorize
//
//  Created by Ling on 2023/12/8.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount:Int = 3
    let emojis = ["👻","💩","🤡","😈","🎃","🍐","🍉","🍇","🍒"]
    var body: some View {

        ScrollView{
            cards
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]){
            ForEach(emojis.indices, id:\.self){index in
                CardView(emoji: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
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
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(emoji).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            print("tapped")
            //isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
    }
}
