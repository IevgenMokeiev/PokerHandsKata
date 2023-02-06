//
//  Array+Extensions.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 15.08.2022.
//

import Foundation

extension Array where Element: Hashable {
    var duplicatesMap: [Element : Int] {
        let repeatingElements = Dictionary(
            grouping: self,
            by: { $0 }
        ).filter { $1.count > 1 }
        
        return repeatingElements.mapValues { $0.count }
    }
}

extension Array where Element == Int {
    var isSequential: Bool {
        let sorted = sorted()
        return (sorted.map { $0 - 1 }.dropFirst() == sorted.dropLast())
    }

    func isRankedLessThan(_ otherArray: [Int]) -> Bool {
        var result = false
        for (element1, elemen2) in zip(self, otherArray) {
            if element1 != elemen2 {
                result = element1 < elemen2
                break
            }
        }
        return result
    }
}

extension Array where Element == PokerCard {
    var sortedRanks: [Int] {
        return map { $0.value.rank }.sorted { $0 > $1 }
    }

    var values: [Value] {
        return map { $0.value }
    }
}

extension Array where Element == Value {
    func sortedRanks(except values: [Value]) -> [Int] {
        return filter { !values.contains($0) }
            .map { $0.rank }
            .sorted { $0 > $1 }
    }
}
