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
        let repeatingValues = values.duplicatesMap
        let repeatingValuesKeysArray = Array(repeatingValues.keys)

        guard repeatingValuesKeysArray.count == 1,
              let value = repeatingValuesKeysArray.first else {
            return nil
        }

        switch repeatingValues[value] {
        case 4:
            return .fourOfAKind(value.rank)
        default:
            return nil
        }
    }
}
