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
        let sortedCards = cards.sortedRanks
        return Combo(comboType: .highCard, rankingArray: sortedCards)
    }

    func determineCombo(cards: [PokerCard]) -> Combo? {
        return Self.highCardCombo(cards: cards)
    }
}