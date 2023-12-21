//
//  ContentView.swift
//  Memorize
//
//  Created by Ling on 2023/12/8.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel:EmojiMemoryGame

    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            themeNameAndScoreBar
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            .padding()
            buttonBar
        }
    }
    
    // title bar shows theme name and score
    var themeNameAndScoreBar: some View{
        HStack{
            Spacer()
            Text(viewModel.currentTheme.name).font(.title)
            Spacer()
            Text("score:\(viewModel.getScore())").font(.title)
            Spacer()
        }
    }
    
    // Buttons: shuffle the cards and start new game
    var buttonBar: some View{
        HStack{
            Spacer()
            buttonTemplate(action: {viewModel.shuffle()}, imgName: "dice", text: "Shuffle")
            Spacer()
            buttonTemplate(action: {
                viewModel.newGame()
            }, imgName: "gamecontroller", text: "New Game")
            Spacer()
        }
    }
    
    // Button template
    private func buttonTemplate(action:@escaping()->Void,imgName:String,text:String)->some View{
        Button(action: action, label: {
            VStack{
                Image(systemName:imgName).font(.title).imageScale(.medium)
                Text(text).font(.system(size:10))
            }
        })
    }
    
    // Draw cards in the view
    var cards: some View{
        LazyVGrid(columns:[GridItem(.adaptive(minimum:85),spacing:0)],spacing:0){
            ForEach(viewModel.cards){card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.currentTheme.color)
        
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

// Define of card view
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card){
        self.card  = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
