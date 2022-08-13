//
//  PokerHandsKataTests.swift
//  PokerHandsKataTests
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import XCTest
@testable import PokerHandsKata

class PokerHandsKataTests: XCTestCase {

  func test_whenCardInputDataCorrect_thenInitialization() throws {
    let card1 = PokerCard(stringRepresentation: "2H")
    XCTAssertNotNil(card1)
    XCTAssertEqual(card1?.suit, Suit.hearts)
    XCTAssertEqual(card1?.value, Value.two)

    let card2 = PokerCard(stringRepresentation: "JC")
    XCTAssertNotNil(card2)
    XCTAssertEqual(card2?.suit, Suit.clubs)
    XCTAssertEqual(card2?.value, Value.jack)
  }

  func test_whenCardInputDataIncorrect_thenReturnsNil() throws {
    let card1 = PokerCard(stringRepresentation: "2P")
    XCTAssertNil(card1)

    let card2 = PokerCard(stringRepresentation: "2H3")
    XCTAssertNil(card2)

    let card3 = PokerCard(stringRepresentation: "2")
    XCTAssertNil(card3)
  }

  func test_whenHandDataIncorrect_thenReturnsNil() throws {
    let hand1 = PokerHand(stringRepresentation: "2H 3D 5S 9C KD 5S")
    XCTAssertNil(hand1)

    let hand2 = PokerHand(stringRepresentation: "2H 3D 5S 9C")
    XCTAssertNil(hand2)

    let hand3 = PokerHand(stringRepresentation: "2H 3D 5S 9C KQ")
    XCTAssertNil(hand3)
  }

  func test_whenHighCardsOnly_thenHighestWins() throws {
    guard let black = PokerHand(stringRepresentation: "2H 3D 5S 9C KD") else {
      XCTFail("corrupted hand")
      return
    }
    XCTAssertEqual(black.combo, .highCard(13))

    guard let white = PokerHand(stringRepresentation: "2C 3H 4S 8C AH") else {
      XCTFail("corrupted hand")
      return
    }
    XCTAssertEqual(white.combo, .highCard(14))

    XCTAssertTrue(black < white)
  }

  func test_whenOneHasPair_thenPairWins() throws {
    guard let black = PokerHand(stringRepresentation: "2H 3D 5S 9C 9D") else {
      XCTFail("corrupted hand")
      return
    }
    XCTAssertEqual(black.combo, .pair(9))

    guard let white = PokerHand(stringRepresentation: "2C 3H 4S 8C AH") else {
      XCTFail("corrupted hand")
      return
    }
    XCTAssertEqual(white.combo, .highCard(14))

    XCTAssertTrue(black > white)
  }
}
