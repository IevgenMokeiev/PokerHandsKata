//
//  PokerHand.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import Foundation

struct PokerHand: Comparable, Equatable {
    
    let cards: [PokerCard]
    let combo: Combo
    
    var stringRepresentation: String {
        return cards.map { $0.stringRepresentation }.joined(separator: " ")
    }
    
    init?(cards: [PokerCard]) {
        guard cards.count == 5 else {
            return nil
        }
        self.cards = cards
        self.combo = Self.determineCombo(cards: cards)
    }
    
    init?(stringRepresentation: String) {
        let cardStrings = stringRepresentation.split(separator: " ").map { String($0) }
        let cards = cardStrings.compactMap({ PokerCard(stringRepresentation: $0) })
        self.init(cards: cards)
    }
    
    static func < (lhs: PokerHand, rhs: PokerHand) -> Bool {
        return lhs.combo < rhs.combo
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.combo == rhs.combo
    }
    
    // MARK: - Private

    private static func determineCombo(cards: [PokerCard]) -> Combo {
        var resultCombo: Combo?
        for comboDetector in comboDetectors {
            if let combo = comboDetector.determineCombo(cards: cards) {
                resultCombo = combo
                break
            }
        }

        if let resultCombo{
            return resultCombo
        } else {
            return HighCardComboDetector.highCardCombo(cards: cards)
        }
    }

    private static var comboDetectors: [ComboDetector] = {
        return ComboType.allCases.reversed()
            .map { $0.comboDetectorType.make() }
    }()
}
