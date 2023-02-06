//
//  Array+Extensions.swift
//  PokerHandsKata
//
//  Created by Yevhen Mokeiev on 15.08.2022.
//

import Foundation

extension Array where Element: Hashable {

    var duplicatesMap: [Element : Int] {
        return Dictionary(grouping: self, by: { $0 } )
            .filter { $1.count > 1 }
            .mapValues { $0.count }
    }
}

extension Array : Comparable where Element == Int {

    var isSequential: Bool {
        let sorted = sorted()
        return (sorted.map { $0 - 1 }.dropFirst() == sorted.dropLast())
    }

    public static func < (lhs: Array, rhs: Array) -> Bool {
        let diffResult = zip(lhs, rhs)
            .first { $0 != $1 }
            .map { $0.0 < $0.1 }

        return diffResult ?? false
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
