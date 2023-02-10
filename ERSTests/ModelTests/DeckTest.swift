//
//  DeckTest.swift
//  ERSTests
//
//  Created by Hersh Nagpal on 1/20/23.
//

import XCTest
@testable import ERS

class DeckTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeckCreate() throws {
        let deck = Deck()
        for suit in Suit.allCases {
            for value in Value.allCases {
                XCTAssertTrue(deck.draw()?.toString() == "\(value) of \(suit)")
            }
        }
        XCTAssertTrue(deck.numCards() == 0)
    }
    
    func testDeckDraw() throws {
        let deck = Deck()
        XCTAssertTrue(deck.numCards() == 52)
        XCTAssertTrue(deck.draw()?.toString() == "ace of diamonds")
        XCTAssertTrue(deck.numCards() == 51)
    }
    
    func testDeckPeek() throws {
        let deck = Deck()
        XCTAssertTrue(deck.numCards() == 52)
        XCTAssertTrue(deck.peek()?.toString() == "ace of diamonds")
        XCTAssertTrue(deck.numCards() == 52)
    }
    
    func testDeckShuffle() throws {
        let deck = Deck()
        let shuffled = Deck()
        XCTAssertTrue(deck.peek()?.toString() == "ace of diamonds")
        XCTAssertTrue(shuffled.peek()?.toString() == "ace of diamonds")
        shuffled.shuffle()
        XCTAssertTrue(deck.peek()?.toString() == "ace of diamonds")
        XCTAssertFalse(shuffled.peek()?.toString() == "ace of diamonds")
    }
    
    func testDiscard() throws {
        let deck = Deck()
        XCTAssertTrue(deck.peek()?.toString() == "ace of diamonds")
        deck.discard(26)
        XCTAssertTrue(deck.peek()?.toString() == "ace of hearts")
    }
    
    func testAddCards() throws {
        let deck = Deck()
        XCTAssertTrue(deck.peek()?.toString() == "ace of diamonds")
        XCTAssertTrue(deck.numCards() == 52)
        deck.addCards([Card(value: .queen, suit: .hearts)])
        XCTAssertTrue(deck.numCards() == 53)
        deck.addCards([Card(value: .queen, suit: .hearts), Card(value: .queen, suit: .hearts)])
        XCTAssertTrue(deck.numCards() == 55)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
