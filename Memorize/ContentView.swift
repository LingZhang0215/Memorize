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
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            cardAdjuster
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id:\.self){index in
                CardView(emoji: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardAdjuster: some View{
        HStack{
            cardRemover
            Spacer()
            cardAdder
            
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCoundAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action:{
            cardCount += offset
        }, label:{
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View{
        cardCoundAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View{
        cardCoundAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
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
