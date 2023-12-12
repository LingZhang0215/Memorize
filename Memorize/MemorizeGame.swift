//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Ling on 2023/12/12.
//

import Foundation

struct MemorizeGame<CardContent>{
    var cards: Array<Card>
    
    func choose(card: Card){
        
    }
    
    struct Card{
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
