//
//  PokerHand.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import Foundation

enum Combo: Comparable {
  case highCard(Int, Int, Int, Int, Int)
  case pair(Int, Int, Int, Int)
  case twoPairs(Int, Int, Int)
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
    if let combo = determineCardWithSameValue() {
      return combo
    } else {
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

  private func determineCardWithSameValue() -> Combo? {
    let values = cards.map { $0.value }
    let repeatingValues = Dictionary(
      grouping: values,
      by: { $0 }
    ).filter { $1.count > 1 }.keys
    let repeatingValuesArray = Array(repeatingValues)

    switch repeatingValuesArray.count {
    case 0:
      return nil
    case 1:
      let value = repeatingValuesArray.first
      let count = values.filter { $0 == value }.count
      let otherRanks = values
        .filter { $0 != value }
        .map { $0.rank }
        .sorted { $0 > $1 }
      let rank = value?.rank ?? 0
      switch count {
      case 2:
        return .pair(rank, otherRanks[0], otherRanks[1], otherRanks[2])
      case 3:
        return .threeOfAKind(rank)
      case 4:
        return .fourOfAKind(rank)
      default:
        return nil
      }
    case 2:
      let value1 = repeatingValuesArray[0]
      let count1 = values.filter { $0 == value1 }.count
      let value2 = repeatingValuesArray[1]
      let count2 = values.filter { $0 == value2 }.count

      switch (count1, count2) {
      case (2, 2):
        let otherCardRank = values
          .filter { $0 != value1 && $0 != value2 }
          .map { $0.rank}
          .first

        guard let otherCardRank = otherCardRank else {
          return nil
        }

        let ranks = [value1.rank, value2.rank, otherCardRank].sorted { $0 > $1 }
        return .twoPairs(ranks[0], ranks[1], ranks[2])
      case (2, 3):
        return .fullHouse(value2.rank)
      case (3, 2):
        return .fullHouse(value1.rank)
      default:
        return nil
      }
    default:
      return nil
    }
  }
}
