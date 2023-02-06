//
//  FullHouseComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

class FullHouseComboDetector: ComboDetector {

    required init() {}

    static func make() -> Self {
        return self.init()
    }

    func determineCombo(cards: [PokerCard]) -> Combo? {
        let values = cards.values
        let repeatingValues = values.duplicatesMap
        let repeatingValuesKeysArray = Array(repeatingValues.keys)

        guard  repeatingValuesKeysArray.count == 2 else {
            return nil
        }

        let value1 = repeatingValuesKeysArray[0]
        let value2 = repeatingValuesKeysArray[1]
        switch (repeatingValues[value1], repeatingValues[value2]) {
        case (2, 3):
            return Combo(comboType: .fullHouse, rankingArray: [value2.rank])
        case (3, 2):
            return Combo(comboType: .fullHouse, rankingArray: [value1.rank])
        default:
            return nil
        }
    }
}

