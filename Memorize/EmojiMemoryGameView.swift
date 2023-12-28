//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ling on 2023/12/8.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    private let cardAspectRatio: CGFloat = 2/3
    var body: some View {
        VStack{
            
            cards
                .animation(.default, value: viewModel.cards)
            
                .padding()
            Button("Shuffle"){
                viewModel.shuffle()
            }
        }
        
    }
    
    
    private var cards: some View{
        AspectVGrid(items: viewModel.cards,aspectRatio:cardAspectRatio){card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card){
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 20)
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size:200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
