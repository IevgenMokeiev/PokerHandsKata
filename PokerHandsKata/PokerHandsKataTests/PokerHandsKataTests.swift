//
//  PokerHandsKataTests.swift
//  PokerHandsKataTests
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import XCTest
@testable import PokerHandsKata

class PokerHandsKataTests: XCTestCase {

  func test_whenInputDataCorrect_thenInitialization() throws {
    let card = PokerCard(stringRepresentation: "2H")
    XCTAssertNotNil(card)
    XCTAssertEqual(card?.suit, Suit.hearts)
    XCTAssertEqual(card?.value, Value.two)
  }

  func test_whenInputDataIncorrect_thenReturnsNil() throws {
    let card = PokerCard(stringRepresentation: "2P")
    XCTAssertNil(card)
  }
}
