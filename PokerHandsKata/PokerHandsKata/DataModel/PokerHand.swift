//
//  PokerHand.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import Foundation

enum Combo: Comparable, Equatable {
  case highCard(Int, Int, Int, Int, Int)
  case pair(Int, Int, Int, Int)
  case twoPairs(Int, Int, Int)
  case threeOfAKind(Int)
  case straight(Int)
  case flush(Int, Int, Int, Int, Int)
  case fullHouse(Int)
  case fourOfAKind(Int)
  case straightFlash(Int)
}

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
    let flushCombo = determineFlush()
    let straightCombo = determineStraight()

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
    let values = cards.map { $0.value }
    let repeatingValues = values.findDuplicates()
    let repeatingValuesKeysArray = Array(repeatingValues.keys)

    switch repeatingValuesKeysArray.count {
    case 0:
      return nil
    case 1:
      guard let value = repeatingValuesKeysArray.first else {
        return nil
      }
      let count = repeatingValues[value]
      let otherRanks = values
        .filter { $0 != value }
        .map { $0.rank }
        .sorted { $0 > $1 }
      let rank = value.rank
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
      let value1 = repeatingValuesKeysArray[0]
      let value2 = repeatingValuesKeysArray[1]
      let count1 = repeatingValues[value1]
      let count2 = repeatingValues[value2]

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

  private func determineStraight() -> Combo? {
    if sortedRanks.isSequential() {
      return .straight(sortedRanks.first ?? 0)
    } else {
       let moduleRanks = cards.map { $0.value.rank > 10 ? $0.value.rank - 13 : $0.value.rank }.sorted { $0 > $1 }
       if moduleRanks.isSequential() {
          return .straight(sortedRanks.first ?? 0)
       } else {
          return nil
       }
    }
  }

  private func determineFlush() -> Combo? {
    let suites = cards.map { $0.suit }
    let repeatingSuites = suites.findDuplicates()

    if repeatingSuites.keys.count == 1,
        let suit = repeatingSuites.keys.first {
      switch repeatingSuites[suit] {
      case 5:
        return .flush(
          sortedRanks[0],
          sortedRanks[1],
          sortedRanks[2],
          sortedRanks[3],
          sortedRanks[4]
        )
      default:
        return nil
      }
    } else {
      return nil
    }
  }

  // MARK: - Utility

  var sortedRanks: [Int] {
    return cards.map { $0.value.rank }.sorted { $0 > $1 }
  }
}
