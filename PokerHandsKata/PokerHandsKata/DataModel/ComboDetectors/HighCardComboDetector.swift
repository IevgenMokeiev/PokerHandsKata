//
//  HighCardComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 06.02.2023.
//

import Foundation

class HighCardComboDetector: ComboDetector {

    required init() {}

    static func make() -> Self {
        return self.init()
    }

    static func highCardCombo(cards: [PokerCard]) -> Combo {
        return Combo(comboType: .highCard, rankingArray: cards.sortedRanks)
    }

    func detectCombo(cards: [PokerCard]) -> Combo? {
        return Self.highCardCombo(cards: cards)
    }
}
