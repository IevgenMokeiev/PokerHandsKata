//
//  Array+Extensions.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 15.08.2022.
//

import Foundation

extension Array where Element: Hashable {
  func findDuplicates() -> [Element : Int] {
    let repeatingElements = Dictionary(
      grouping: self,
      by: { $0 }
    ).filter { $1.count > 1 }

    return repeatingElements.mapValues { $0.count }
  }
}

extension Array where Element == Int {
  func isSequential() -> Bool {
    let sorted = sorted()
    return (sorted.map { $0 - 1 }.dropFirst() == sorted.dropLast())
  }
}
