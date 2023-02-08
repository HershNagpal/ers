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
        XCTAssertTrue(deck.deck.isEmpty)
    }
    
    func testDeckPeekDraw() throws {
        let deck = Deck()
        XCTAssertTrue(deck.deck.count == 52)
        XCTAssertTrue(deck.draw()?.toString() == "ace of diamonds")
        XCTAssertTrue(deck.deck.count == 51)
    }
    
    func testDiscard() throws {
        let deck = Deck()
        XCTAssertTrue(deck.peek()?.toString() == "ace of diamonds")
        deck.discard(26)
        XCTAssertTrue(deck.peek()?.toString() == "ace of hearts")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
