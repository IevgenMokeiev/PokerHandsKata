//
//  PokerCard.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import Foundation

struct PokerCard: Equatable {
    
    let value: Value
    let suit: Suit
    
    var stringRepresentation: String {
        return value.rawValue + suit.rawValue
    }
    
    init(value: Value, suit: Suit) {
        self.value = value
        self.suit = suit
    }
    
    init?(stringRepresentation: String) {
        var mutablestringRep = stringRepresentation
        let suitRep = mutablestringRep.last
        mutablestringRep.removeLast()
        let valueRep = mutablestringRep
        
        guard let suitRep, valueRep.count == 1 || valueRep.count == 2 else {
            return nil
        }
        
        guard let suit = Suit(rawValue: String(suitRep)) else {
            return nil
        }
        
        guard let value = Value(rawValue: String(valueRep)) else {
            return nil
        }
        
        self.init(value: value, suit: suit)
    }
}

