//
//  PokerCard.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import Foundation

enum Suit: String, Equatable {
    case clubs = "C"
    case diamonds = "D"
    case hearts = "H"
    case spades = "S"
}

enum Value: String, CaseIterable, Comparable, Equatable {
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case ace = "A"
    
    var rank: Int {
        return (Self.allCases.firstIndex(of: self) ?? 0) + 2
    }
    
    static func < (lhs: Value, rhs: Value) -> Bool {
        return lhs.rank < rhs.rank
    }
}

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

