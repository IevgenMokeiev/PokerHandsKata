//
//  StraightFlushComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

class StraightFlushComboDetector: ComboDetector {

    private let straightComboDetector = StraightComboDetector()
    private let flushComboDetector = FlushComboDetector()

    required init() {}

    static func make() -> Self {
        return self.init()
    }

    func determineCombo(cards: [PokerCard]) -> Combo? {
        if straightComboDetector.determineCombo(cards: cards) != nil,
           flushComboDetector.determineCombo(cards: cards) != nil {
            return Combo(
                comboType: .straightFlash,
                rankingArray: [cards.sortedRanks.first ?? 0]
            )
        } else {
            return nil
        }
    }
}

