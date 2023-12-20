//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Ling on 2023/12/12.
//

import Foundation

struct MemoryGame<CardContent> where CardContent:Equatable{
    //private(set) means only allow the see the card externally, cannot change the value.
    private(set) var cards: Array<Card>
    
    init(numberOfPairCards: Int, cardContentFactory:(Int)->CardContent) {
        cards = []
        for pairIndex in 0..<max(2,numberOfPairCards){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content:content,id:"\(pairIndex+1)a"))
            cards.append(Card(content:content,id:"\(pairIndex+1)b"))
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{
//            var faceUpCardIndices = [Int]()
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1{
//                return faceUpCardIndices.first
//            }else{
//                return nil
//            }
            cards.indices.filter {index in cards[index].isFaceUp}.only
        }
        set{
//            for index in cards.indices{
//                if index == newValue{
//                    cards[index].isFaceUp = true
//                }else{
//                    cards[index].isFaceUp = false
//                }
//            }
            cards.indices.forEach{cards[$0].isFaceUp = ($0 == newValue)}
        }
    }
    
    mutating func choose(_ card: Card){
//        if let chosenIndex = index(of: card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                }else{
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
            }
            cards[chosenIndex].isFaceUp = true
        }
        
    }
    
//    private func index(of card:Card)->Int?{
//        for index in cards.indices{
//            if cards[index].id == card.id{
//                return index
//            }
//        }
//        return nil
//    }
    
    struct Card:Equatable,Identifiable,CustomDebugStringConvertible{
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id:String
        var debugDescription: String{
            "\(id):\(content) \(isFaceUp ? "Up":"Down") \(isMatched ? "Matched": "Not")"
        }
    }
}

extension Array{
    var only: Element?{
        count == 1 ? first : nil
    }
}
