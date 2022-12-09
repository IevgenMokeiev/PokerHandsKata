//
//  PokerHandsKataTests.swift
//  PokerHandsKataTests
//
//  Created by Yevhen Mokeiev on 12.08.2022.
//

import XCTest
@testable import PokerHandsKata

class PokerHandsKataTests: XCTestCase {

   private enum MatchResult {
      case firstWins
      case secondWins
      case tie
   }

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

   func test_whenTwoHighCards_thenHighestWins() throws {
      expectHands(
         hand1String: "2H 3D 5S 9C KD",
         hand2String: "2C 3H 4S 8C KH",
         expectedCombo1: .highCard(13, 9, 5, 3, 2),
         expectedCombo2: .highCard(13, 8, 4, 3, 2),
         expectedResult: .firstWins
      )
   }

   func test_whenTwoHighCardsWithSameRank_thenTie() throws {
      expectHands(
         hand1String: "2H 3D 5S 9C KD",
         hand2String: "2D 3H 5C 9S KH",
         expectedCombo1: .highCard(13, 9, 5, 3, 2),
         expectedCombo2: .highCard(13, 9, 5, 3, 2),
         expectedResult: .tie
      )
   }

   func test_whenOnePair_thenPairWins() throws {
      expectHands(
         hand1String: "2H 3D 5S 9C 9D",
         hand2String: "2C 3H 4S 8C AH",
         expectedCombo1: .pair(9, 5 ,3 ,2),
         expectedCombo2: .highCard(14, 8 ,4 ,3 ,2),
         expectedResult: .firstWins
      )
   }

   func test_whenTwoPairs_thenHighestWins() throws {
      expectHands(
         hand1String: "2H 3D 5S 9C 9D",
         hand2String: "2C 3H 4S 8C 8H",
         expectedCombo1: .pair(9, 5 ,3 ,2),
         expectedCombo2: .pair(8, 4 ,3 ,2),
         expectedResult: .firstWins
      )
   }

   func test_whenTwoEqualPairs_thenHighestOtherCardWins() throws {
      expectHands(
         hand1String: "2H 3D 5S 9C 9D",
         hand2String: "2C 3H 4S 9C 9H",
         expectedCombo1: .pair(9, 5 ,3 ,2),
         expectedCombo2: .pair(9, 4 ,3 ,2),
         expectedResult: .firstWins
      )
   }

   func test_whenPairAndTwoPairs_thenTwoPairsWins() throws {
      expectHands(
         hand1String: "2H 3D 5S 9C 9D",
         hand2String: "2C 4H 4S 9C 9H",
         expectedCombo1: .pair(9, 5, 3 ,2),
         expectedCombo2: .twoPairs(9, 4 ,2),
         expectedResult: .secondWins
      )
   }

   func test_whenThreeAndTwoPairs_thenThreeWins() throws {
      expectHands(
         hand1String: "2H 3D 9S 9C 9D",
         hand2String: "2C 4H 4S 9C 9H",
         expectedCombo1: .threeOfAKind(9),
         expectedCombo2: .twoPairs(9, 4, 2),
         expectedResult: .firstWins
      )
   }

   func test_whenTwoThrees_thenHighestWins() throws {
      expectHands(
         hand1String: "2H 3D 9S 9C 9D",
         hand2String: "2C 4H 10S 10C 10H",
         expectedCombo1: .threeOfAKind(9),
         expectedCombo2: .threeOfAKind(10),
         expectedResult: .secondWins
      )
   }

   func test_whenStraightAndThree_thenStraightWins() throws {
      expectHands(
         hand1String: "2H 3S 4C 5D 6H",
         hand2String: "2S 8S 10C 10S 10H",
         expectedCombo1: .straight(6),
         expectedCombo2: .threeOfAKind(10),
         expectedResult: .firstWins
      )
   }

   func test_whenTwoStraights_thenHighestWins() throws {
      expectHands(
         hand1String: "2H 3S 4C 5D 6H",
         hand2String: "3S 4S 5C 6S 7H",
         expectedCombo1: .straight(6),
         expectedCombo2: .straight(7),
         expectedResult: .secondWins
      )
   }

   func test_whenFlushAndStraight_thenFlushWins() throws {
      expectHands(
         hand1String: "2H 3S 4C 5D 6H",
         hand2String: "2S 8S 10S QS AS",
         expectedCombo1: .straight(6),
         expectedCombo2: .flush(14, 12, 10, 8, 2),
         expectedResult: .secondWins
      )
   }

   func test_whenTwoFlushes_thenHighestWins() throws {
      expectHands(
         hand1String: "2H 3H 4H 5H 7H",
         hand2String: "2S 8S 10S QS AS",
         expectedCombo1: .flush(7, 5, 4, 3, 2),
         expectedCombo2: .flush(14, 12, 10, 8, 2),
         expectedResult: .secondWins
      )
   }

   func test_whenFullHouseAndFlush_thenFullHouseWins() throws {
      expectHands(
         hand1String: "2H 4S 4C 2D 4H",
         hand2String: "2S 8S AS QS 3S",
         expectedCombo1: .fullHouse(4),
         expectedCombo2: .flush(14, 12, 8, 3, 2),
         expectedResult: .firstWins
      )
   }

   func test_whenTwoFullHouses_thenHighestWins() throws {
      expectHands(
         hand1String: "2H 4S 4C 2D 4H",
         hand2String: "3S 8S 3S 8H 8C",
         expectedCombo1: .fullHouse(4),
         expectedCombo2: .fullHouse(8),
         expectedResult: .secondWins
      )
   }

   func test_whenFullHouseAndFour_thenFourWins() throws {
      expectHands(
         hand1String: "2H 4S 4C 2D 4H",
         hand2String: "3S 10S 10H 10D 10C",
         expectedCombo1: .fullHouse(4),
         expectedCombo2: .fourOfAKind(10),
         expectedResult: .secondWins
      )
   }

   func test_whenTwoFours_thenHighestWins() throws {
      expectHands(
         hand1String: "7H 4S 7C 7D 7S",
         hand2String: "3S 10S 10H 10D 10C",
         expectedCombo1: .fourOfAKind(7),
         expectedCombo2: .fourOfAKind(10),
         expectedResult: .secondWins
      )
   }

   func test_whenFourAndStraightFlush_thenStraightFlushWins() throws {
      expectHands(
         hand1String: "7H 4S 7C 7D 7S",
         hand2String: "3S 4S 5S 6S 7S",
         expectedCombo1: .fourOfAKind(7),
         expectedCombo2: .straightFlash(7),
         expectedResult: .secondWins
      )
   }

   func test_whenTwoStraightFlushes_thenHighestWins() throws {
      expectHands(
         hand1String: "7D 8D 9D 10D JD",
         hand2String: "3S 4S 5S 6S 7S",
         expectedCombo1: .straightFlash(11),
         expectedCombo2: .straightFlash(7),
         expectedResult: .firstWins
      )
   }

   // MARK: - Private

   private func expectHands(
      hand1String: String,
      hand2String: String,
      expectedCombo1: Combo,
      expectedCombo2: Combo,
      expectedResult: MatchResult,
      file: StaticString = #file,
      line: UInt = #line
   ) {
      guard let hand1 = PokerHand(stringRepresentation: hand1String) else {
         XCTFail("corrupted hand", file: file, line: line)
         return
      }
      XCTAssertEqual(hand1.combo, expectedCombo1, file: file, line: line)

      guard let hand2 = PokerHand(stringRepresentation: hand2String) else {
         XCTFail("corrupted hand", file: file, line: line)
         return
      }
      XCTAssertEqual(hand2.combo, expectedCombo2, file: file, line: line)

      switch expectedResult {
      case .firstWins:
         XCTAssertTrue(hand1 > hand2, "incorrect match result", file: file, line: line)
      case .secondWins:
         XCTAssertTrue(hand1 < hand2, "incorrect match result", file: file, line: line)
      case .tie:
         XCTAssertEqual(hand1, hand2, "incorrect match result", file: file, line: line)
      }
   }
}
