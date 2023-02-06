//
//  TwoPairsComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

class TwoPairsComboDetector: ComboDetector {

    required init() {}

    static func make() -> Self {
        return self.init()
    }

    func detectCombo(cards: [PokerCard]) -> Combo? {
        let values = cards.values
        let repeatingValues = values.duplicatesMap
        let repeatingValuesKeysArray = Array(repeatingValues.keys)

        guard  repeatingValuesKeysArray.count == 2 else {
            return nil
        }

        let value1 = repeatingValuesKeysArray[0]
        let value2 = repeatingValuesKeysArray[1]
        let count1 = repeatingValues[value1]
        let count2 = repeatingValues[value2]

        switch (count1, count2) {
        case (2, 2):
            guard let otherCardRank = values.sortedRanks(except: [value1, value2]).first else {
                return nil
            }
            let ranks = [value1.rank, value2.rank, otherCardRank].sorted { $0 > $1 }
            return Combo(comboType: .twoPairs, rankingArray: ranks)
        default:
            return nil
        }
    }
}
