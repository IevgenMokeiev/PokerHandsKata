//
//  FourOfAKindComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

class FourOfAKindComboDetector: ComboDetector {

    required init() {}

    static func make() -> Self {
        return self.init()
    }

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
            return Combo(comboType: .fourOfAKind, rankingArray: [value.rank])
        default:
            return nil
        }
    }
}
