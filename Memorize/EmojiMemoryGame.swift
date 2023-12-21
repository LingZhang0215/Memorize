//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ling on 2023/12/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    private static let themes = [GameTheme(name: "fruit", emojis: ["🍐","🍉","🍇","🍒","🍓","🍊","🍌"], pairs: 7, color: Color.orange),GameTheme(name: "transportation", emojis: ["🚔","🚕","🏎️","🚅","🛵","✈️","🛥️"], pairs: 6, color: Color.blue),GameTheme(name: "food", emojis: ["🍟","🍔","🌭","🥪","🍣","🥗","🍝","🌮"], pairs:8 , color: Color.yellow),GameTheme(name: "sport", emojis: ["⚽️","🏀","🏈","🎾","🎱","🥏","⛳️","🏸"], pairs:7, color: Color.green),GameTheme(name: "animal", emojis: ["🐶","🐱","🐻","🦁","🐸","🐷"], pairs: 6, color: Color.pink),GameTheme(name: "drink", emojis: ["🧋","🧃","🍼","☕️","🍻","🍾","🧉"], pairs: 6, color: Color.purple)]
    
    private static func createMemoryGame(theme: GameTheme)->MemoryGame<String>{
        let currentEmojiSet = theme.emojis.shuffled()
        return MemoryGame(numberOfPairs:min(theme.pairs,theme.emojis.count)) { pairIndex in
            return currentEmojiSet[pairIndex]
        }
    }
    
    // create Model and track the changes
    @Published private var model = createMemoryGame(theme: themes[0])
    private(set) var currentTheme = themes[0]
    
    
    
    var cards:Array<MemoryGame<String>.Card>{
        return model.cards
    }
    //MARK: Intent
    
    func shuffle(){
        return model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        return model.choose(card)
    }
    
    func newGame(){
        currentTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
    }
    
    func getScore()->Int{
        return model.score
    }
    
}

