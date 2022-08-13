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

    if lhs.combo < rhs.combo {
      return true
    } else if rhs.combo < lhs.combo {
      return false
    } else {
      let lhsRank = lhs.highestCardRank()
      let rhsRank = rhs.highestCardRank()
      return lhsRank < rhsRank
    }
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

  private func highestCardRank() -> Int {
    let sortedCards = cards.sorted { $0.value < $1.value }
    return sortedCards.last?.value.rank ?? 0
  }

  private func determineEquals() -> Combo? {
    let values = cards.map { $0.value }
    let duplicatingValues = Dictionary(
      grouping: values,
      by: { $0 }
    ).filter { $1.count > 1 }.keys

    switch duplicatingValues.count {
    case 0:
      return nil
    case 1:
      let value = duplicatingValues.first
      let count = values.filter { $0 == value }.count
      let cardRank = value?.rank ?? 0
      switch count {
      case 2:
        return .pair(cardRank)
      case 3:
        return .threeOfAKind(cardRank)
      case 4:
        return .fourOfAKind(cardRank)
      default:
        return nil
      }
    case 2:
      // expand
      return nil
    default:
      return nil
    }
  }
}
