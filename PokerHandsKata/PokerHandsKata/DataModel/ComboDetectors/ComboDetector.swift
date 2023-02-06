//
//  ComboDetector.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

protocol ComboDetector {

    static func make() -> Self
    func detectCombo(cards: [PokerCard]) -> Combo?
}
