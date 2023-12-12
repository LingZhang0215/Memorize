//
//  ContentView.swift
//  Memorize
//
//  Created by Ling on 2023/12/8.
//

import SwiftUI

struct ContentView: View {
    @State var emojis:Array<String> = ["🚒","🚒","🚓","🚓","🛵","🛵","🛺","🛺","🚔","🚔"]
    @State var backColor = Color.blue
    var body: some View {
        
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView{
                cards
            }
            themeChoice
        }
        .padding()
    }
    
    var cards: some View{
        let pairCount = Int.random(in: 2...emojis.count/2)
        
        let partEmojiSet = emojis[0..<pairCount*2].shuffled()
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]){
            ForEach(0..<partEmojiSet.count, id:\.self){index in
                CardView(emoji: partEmojiSet[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(backColor)
    }
    
    func themeButtion(bColor:Color, emojiset:Array<String>, text: String, symbol: String) -> some View{
        Button(action:{
            backColor = bColor
            emojis = emojiset
        },label:{
            VStack{
                Image(systemName: symbol)
                    .font(.title)
                    .imageScale(.medium)
                    
                Text(text).font(.system(size:10))
            }
            
        })
    }

    
    var themeChoice: some View{
        HStack{
            Spacer()
            themeButtion(bColor:Color.blue,emojiset:["🚒","🚒","🚓","🚓","🛵","🛵","🛺","🛺","🚔","🚔"],text: "Vechicles", symbol: "car")
            Spacer()
            themeButtion(bColor:Color.yellow,emojiset:["🥐","🥐","🍞","🍞","🧀","🧀","🍟","🍟","🌮","🌮","🍗","🍗","🍳","🍳"],text: "Food", symbol: "popcorn.circle")
            Spacer()
            themeButtion(bColor:Color.orange,emojiset:["🍊","🍊","🍌","🍌","🍇","🍇","🫐","🫐","🍑","🍑"],text: "Fruit", symbol: "apple.logo")
            Spacer()
            
        }
    }
    
    
}

#Preview {
    ContentView()
}

struct CardView: View {
    let emoji: String
    @State var isFaceUp = false
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
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
