//
//  FullHouseComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

class FullHouseComboDetector: ComboDetector {

    func determineCombo(cards: [PokerCard]) -> Combo? {
        let values = cards.values
        let repeatingValues = values.duplicates
        let repeatingValuesKeysArray = Array(repeatingValues.keys)
        guard  repeatingValuesKeysArray.count == 2 else {
            return nil
        }
        let value1 = repeatingValuesKeysArray[0]
        let value2 = repeatingValuesKeysArray[1]
        let count1 = repeatingValues[value1]
        let count2 = repeatingValues[value2]

        switch (count1, count2) {
        case (2, 3):
            return .fullHouse(value2.rank)
        case (3, 2):
            return .fullHouse(value1.rank)
        default:
            return nil
        }
    }
}



