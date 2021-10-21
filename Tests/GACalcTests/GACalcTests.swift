import XCTest
@testable import GACalc

final class GACalcTests: XCTestCase {
    func testAddition() throws {
        // given
        var calc = GACalc(initialValue: 5)
        
        // when
        calc.add(4)
        
        // then
        XCTAssertEqual(calc.currentValue, 9)
    }
    
    func testSubtraction() throws {
        // given
        var calc = GACalc(initialValue: 11)
        
        // when
        calc.subtract(20)
        
        // then
        XCTAssertEqual(calc.currentValue, -9)
    }
    
    func testMultiplication() throws {
        // given
        var calc = GACalc(initialValue: 8)
        
        // when
        calc.multiply(6)
        
        // then
        XCTAssertEqual(calc.currentValue, 48)
    }
    
    func testDivision() throws {
        // given
        var calc = GACalc(initialValue: 45)
        
        // when
        calc.divide(-9)
        
        // then
        XCTAssertEqual(calc.currentValue, -5)
    }
    
    func testNegated() throws {
        // given
        var calc = GACalc(initialValue: 15)
        
        // when
        calc.negate()
        
        // then
        XCTAssertEqual(calc.currentValue, -15)
    }
}
