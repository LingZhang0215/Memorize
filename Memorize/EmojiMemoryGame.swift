//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Ling on 2023/12/12.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    private static let emojis = ["👻","💩","🤡","😈","🎃","🍐","🍉","🍇","🍒"]
    
    private static func createMemoryGame()->MemoryGame<String>{
        return MemoryGame(numberOfPairCards: 8){pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }else{
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
