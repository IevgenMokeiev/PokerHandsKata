//
//  FlushComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

class FlushComboDetector: ComboDetector {

    func determineCombo(cards: [PokerCard]) -> Combo? {
        let suites = cards.map { $0.suit }
        let repeatingSuites = suites.duplicates
        let sortedRanks = cards.sortedRanks

        guard repeatingSuites.keys.count == 1,
              let suit = repeatingSuites.keys.first,
              repeatingSuites[suit] == 5 else {
            return nil
        }
        return .flush(
            sortedRanks[0],
            sortedRanks[1],
            sortedRanks[2],
            sortedRanks[3],
            sortedRanks[4]
        )
    }
}

