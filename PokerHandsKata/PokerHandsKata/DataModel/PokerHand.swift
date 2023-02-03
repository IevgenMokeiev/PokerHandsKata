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

        let comboDetectors: [ComboDetector] = [
            StraightFlushComboDetector(),
            FourOfAKindComboDetector(),
            FullHouseComboDetector(),
            FlushComboDetector(),
            StraightComboDetector(),
            ThreeOfAKindComboDetector(),
            TwoPairsComboDetector(),
            PairComboDetector()
        ]

        var resultCombo: Combo?
        for comboDetector in comboDetectors {
            if let combo = comboDetector.determineCombo(cards: cards) {
                resultCombo = combo
                break
            }
        }
        return resultCombo ?? makeHighestCard(cards: cards)
    }
    
    private static func makeHighestCard(cards: [PokerCard]) -> Combo {

        let sortedCards = cards.sortedRanks
        return .highCard(
            sortedCards[0],
            sortedCards[1],
            sortedCards[2],
            sortedCards[3],
            sortedCards[4]
        )
    }
}
