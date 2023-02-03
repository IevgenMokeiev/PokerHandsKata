//
//  StraightFlushComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

struct StraightFlushComboDetector: ComboDetector {

    private let straightComboDetector = StraightComboDetector()
    private let flushComboDetector = FlushComboDetector()

    func determineCombo(cards: [PokerCard]) -> Combo? {
        if straightComboDetector.determineCombo(cards: cards) != nil,
           flushComboDetector.determineCombo(cards: cards) != nil {
            return .straightFlash(cards.sortedRanks.first ?? 0)
        } else {
            return nil
        }
    }
}

