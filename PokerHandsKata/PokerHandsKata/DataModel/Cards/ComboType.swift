//
//  ComboType.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
//

import Foundation

enum ComboType: Equatable, Comparable, CaseIterable {

    case highCard
    case pair
    case twoPairs
    case threeOfAKind
    case straight
    case flush
    case fullHouse
    case fourOfAKind
    case straightFlash

    var comboDetectorType: ComboDetector.Type {

        switch self {
        case .highCard:
            return HighCardComboDetector.self
        case .pair:
            return PairComboDetector.self
        case .twoPairs:
            return TwoPairsComboDetector.self
        case .threeOfAKind:
            return ThreeOfAKindComboDetector.self
        case .straight:
            return StraightComboDetector.self
        case .flush:
            return FlushComboDetector.self
        case .fullHouse:
            return FullHouseComboDetector.self
        case .fourOfAKind:
            return FourOfAKindComboDetector.self
        case .straightFlash:
            return StraightFlushComboDetector.self
        }
    }
}
