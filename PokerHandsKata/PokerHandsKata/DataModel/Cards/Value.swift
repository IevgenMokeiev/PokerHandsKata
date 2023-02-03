//
//  Value.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

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
