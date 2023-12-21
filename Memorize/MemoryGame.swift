//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ling on 2023/12/20.
//

import Foundation


struct MemoryGame<CardContent> where CardContent:Equatable{
    private(set) var cards:Array<Card>
    private(set) var score:Int
    private var cardSeen:Set<String>
    
    init(numberOfPairs:Int, cardContentFactory:(Int)->CardContent){
        cards = []
        score = 0
        cardSeen = []
        for pairIndex in 0..<numberOfPairs{
            let content =  cardContentFactory(pairIndex)
            cards.append(Card(content:content,id:"\(pairIndex+1)a"))
            cards.append(Card(content:content,id:"\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard:Int?{
        get{
            cards.indices.filter {index in cards[index].isFaceUp}.only
        }
        set{
            cards.indices.forEach{cards[$0].isFaceUp = ($0 == newValue)}
        }
    }
    
    mutating func choose(_ card:Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score+=2
                    }
                    else{
                        checkSeen(chosenIndex)
                        checkSeen(potentialMatchIndex)
                    }
                }else{
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
    
    // Check whether the card has been seen before
    mutating func checkSeen(_ index: Int){
        if cardSeen.contains(cards[index].id){
            score -= 1
        }else{
            cardSeen.insert(cards[index].id)
        }
    }
    
    struct Card:Identifiable,Equatable{
        var isFaceUp = false
        var isMatched = false
        var content:CardContent
        var id:String
    }
        
}

extension Array{
    var only:Element?{
        count == 1 ? first : nil
    }
}

