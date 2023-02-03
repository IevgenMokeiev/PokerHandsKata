//
//  FourOfAKindComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

class FourOfAKindComboDetector: ComboDetector {

    func determineCombo(cards: [PokerCard]) -> Combo? {
        let values = cards.values
        let repeatingValues = values.duplicates
        let repeatingValuesKeysArray = Array(repeatingValues.keys)

        guard repeatingValuesKeysArray.count == 1,
              let value = repeatingValuesKeysArray.first else {
            return nil
        }
        let count = repeatingValues[value]
        let otherRanks = values.sortedRanks(except: [value])
        let rank = value.rank
        switch count {
        case 4:
            return .fourOfAKind(rank)
        default:
            return nil
        }
    }
}
