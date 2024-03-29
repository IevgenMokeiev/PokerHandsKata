//
//  PairComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

class PairComboDetector: ComboDetector {

    required init() {}

    static func make() -> Self {
        return self.init()
    }

    func detectCombo(cards: [PokerCard]) -> Combo? {
        let values = cards.values
        let repeatingValues = cards.values.duplicatesMap
        let repeatingValuesKeysArray = Array(repeatingValues.keys)

        guard repeatingValuesKeysArray.count == 1,
                let value = repeatingValuesKeysArray.first else {
            return nil
        }

        let otherRanks = values.sortedRanks(except: [value])
        switch repeatingValues[value] {
        case 2:
            return Combo(
                comboType: .pair,
                rankingArray: [value.rank, otherRanks[0], otherRanks[1], otherRanks[2]]
            )
        default:
            return nil
        }
    }
}


