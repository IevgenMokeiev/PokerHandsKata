//
//  Combo.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 03.02.2023.
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
