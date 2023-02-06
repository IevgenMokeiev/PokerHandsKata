//
//  StraightComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

class StraightComboDetector: ComboDetector {

    required init() {}

    static func make() -> Self {
        return self.init()
    }

    func determineCombo(cards: [PokerCard]) -> Combo? {
        let sortedRanks = cards.sortedRanks

        if sortedRanks.isSequential {
            return Combo(
                comboType: .straight,
                rankingArray: [sortedRanks.first ?? 0]
            )
        } else {
            let moduleRanks = cards
                .map { $0.value.rank > 10 ? $0.value.rank - 13 : $0.value.rank }
                .sorted { $0 > $1 }
            if moduleRanks.isSequential {
                return Combo(
                    comboType: .straight,
                    rankingArray: [sortedRanks.first ?? 0]
                )
            } else {
                return nil
            }
        }
    }
}
