//
//  PokerHand.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import Foundation

enum Combo: Comparable {
  case highCard(Int)
  case pair(Int)
  case twoPairs(Int)
  case threeOfAKind(Int)
  case straight(Int)
  case flush(Int)
  case fullHouse(Int)
  case fourOfAKind(Int)
  case straightFlash(Int)
}

struct PokerHand: Comparable {

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

  // MARK: - Combos

  private func determineCombo() -> Combo {
    if let combo = determineEquals() {
      return combo
    } else {
      return highestCard()
    }
  }

  private func highestCard() -> Combo {
    let sortedCards = cards.sorted { $0.value < $1.value }
    return .highCard(sortedCards.last?.value.rank ?? 0)
  }

  private func determineEquals() -> Combo? {
    let values = cards.map { $0.value }
    let set = Set(values)

    switch set.count {
    case 2:
      return .pair(0)
    case 3:
      return .threeOfAKind(0)
    case 4:
      return .fourOfAKind(0)
    default:
      return nil
    }
  }
}
