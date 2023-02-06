//
//  Combo.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 06.02.2023.
//

import Foundation

struct Combo: Equatable, Comparable {

    var comboType: ComboType
    var rankingArray: [Int]

    static func < (lhs: Combo, rhs: Combo) -> Bool {
        if lhs.comboType < rhs.comboType {
            return true
        } else if lhs.comboType > rhs.comboType {
            return false
        } else {
            return lhs.rankingArray.isRankedLessThan(rhs.rankingArray)
        }
    }
}
