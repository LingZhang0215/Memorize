//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Ling on 2023/12/12.
//

import Foundation

struct MemoryGame<CardContent>{
    //private(set) means only allow the see the card externally, cannot change the value.
    private(set) var cards: Array<Card>
    
    init(numberOfPairCards: Int, cardContentFactory:(Int)->CardContent) {
        cards = []
        for pairIndex in 0..<max(2,numberOfPairCards){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content:content))
            cards.append(Card(content:content))
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    func choose(_ card: Card){
        
    }
    
    struct Card{
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
    }
}
