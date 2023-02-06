//
//  FlushComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

class FlushComboDetector: ComboDetector {

    required init() {}

    static func make() -> Self {
        return self.init()
    }

    func determineCombo(cards: [PokerCard]) -> Combo? {
        let suites = cards.map { $0.suit }
        let repeatingSuites = suites.duplicatesMap
        let sortedRanks = cards.sortedRanks

        guard repeatingSuites.keys.count == 1,
              let suit = repeatingSuites.keys.first,
              repeatingSuites[suit] == 5 else {
            return nil
        }
        return Combo(comboType: .flush, rankingArray: sortedRanks)
    }
}

