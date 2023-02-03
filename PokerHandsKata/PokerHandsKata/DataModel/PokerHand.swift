//
//  PokerHand.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import Foundation

struct PokerHand: Comparable, Equatable {
    
    let cards: [PokerCard]
    
    var stringRepresentation: String {
        return cards.map { $0.stringRepresentation }.joined(separator: " ")
    }
    
    init?(cards: [PokerCard]) {
        guard cards.count == 5 else {
            return nil
        }
        self.cards = cards
    }
    
    init?(stringRepresentation: String) {
        let cardStrings = stringRepresentation.split(separator: " ").map { String($0) }
        let cards = cardStrings.compactMap({ PokerCard(stringRepresentation: $0) })
        
        self.init(cards: cards)
    }
    
    var combo: Combo {
        return determineCombo()
    }
    
    static func < (lhs: PokerHand, rhs: PokerHand) -> Bool {
        return lhs.combo < rhs.combo
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.combo == rhs.combo
    }
    
    // MARK: - Combos
    
    private func determineCombo() -> Combo {
        let sameValuesCombo = determineCardsWithSameValues()
        let flushCombo = FlushComboDetector().determineCombo(cards: cards)
        let straightCombo = StraightComboDetector().determineCombo(cards: cards)
        
        switch (sameValuesCombo, flushCombo, straightCombo) {
        case (_ ,.some(flushCombo), .some(straightCombo)):
            let ranks = cards.map { $0.value.rank }.sorted { $0 < $1 }
            return .straightFlash(ranks.last ?? 0)
        case let (.some(combo1), .some(combo2), nil),
            let (.some(combo1), nil, .some(combo2)):
            return max(combo1, combo2)
        case let (nil, nil, .some(combo)),
            let (nil, .some(combo), nil),
            let (.some(combo), nil, nil):
            return combo
        default:
            return highestCard()
        }
    }
    
    private func highestCard() -> Combo {
        let sortedCards = cards.sorted { $0.value > $1.value }
        let ranks = sortedCards.map { $0.value.rank }
        return .highCard(
            ranks[0],
            ranks[1],
            ranks[2],
            ranks[3],
            ranks[4]
        )
    }
    
    private func determineCardsWithSameValues() -> Combo? {
        let comboDetectors: [ComboDetector] = [
            FourOfAKindComboDetector(),
            FullHouseComboDetector(),
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

        return resultCombo
    }
}
