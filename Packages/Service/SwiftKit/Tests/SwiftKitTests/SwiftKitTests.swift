import XCTest
@testable import SwiftKit


final class SwiftKitTests: XCTestCase {
    
    /// 组合
    func testCombinations() throws {
        let numbers = [10, 20, 30, 40]
        for combo in numbers.combinations(ofCount: 2) {
            print(combo)
        }
        // [10, 20]
        // [10, 30]
        // [10, 40]
        // [20, 30]
        // [20, 40]
        // [30, 40]
        // XCTAssertEqual("1", "Hello, World!")
        print("------------")
        for combo in numbers.combinations(ofCount: 2...3) {
            print(combo)
        }
        // [10, 20]
        // [10, 30]
        // [10, 40]
        // [20, 30]
        // [20, 40]
        // [30, 40]
        // [10, 20, 30]
        // [10, 20, 40]
        // [10, 30, 40]
        // [20, 30, 40]
        
    }
    
    /// 排列
    func testPermutations() throws {
        let numbers = [10, 20, 30]
        for perm in numbers.permutations() {
            print(perm)
        }
        // [10, 20, 30]
        // [10, 30, 20]
        // [20, 10, 30]
        // [20, 30, 10]
        // [30, 10, 20]
        // [30, 20, 10]
        print("------------")
        for perm in numbers.permutations(ofCount: 2) {
            print(perm)
        }
        // [10, 20]
        // [10, 30]
        // [20, 10]
        // [20, 30]
        // [30, 10]
        // [30, 20]
        print("------------")
        for perm in numbers.permutations(ofCount: 0...) {
            print(perm)
        }
        
        print("------------")
        let numbers2 = [20, 10, 10]
        for perm in numbers2.permutations() {
            print(perm)
        }
        // [20, 10, 10]
        // [20, 10, 10]
        // [10, 20, 10]
        // [10, 10, 20]
        // [10, 20, 10]
        // [10, 10, 20]
        print("------------")
        for perm in numbers2.uniquePermutations() {
            print(perm)
        }
        // [20, 10, 10]
        // [10, 20, 10]
        // [10, 10, 20]
    }
    
    func testProduct() throws {
        let seasons = ["winter", "spring", "summer", "fall"]
        for (year, season) in product(1900...2020, seasons) {
            print("\(year)-\(season)")
        }
        print("------------")
        // Is equivalent to:
        for year in 1900...2020 {
            for season in seasons {
                print("\(year)-\(season)")
            }
        }
    }
    
    func testChunked1() throws {
        let numbers = [10, 20, 30, 10, 40, 40, 10, 20]
        let chunks = numbers.chunked(by: { $0 <= $1 })
//        [[10, 20, 30], [10, 40, 40], [10, 20]]
        XCTAssertEqual([[10, 20, 30], [10, 40, 40], [10, 20]], chunks)
    }
    
    func testChunked2() throws {
        let names = ["David", "Kyle", "Karoy", "Nate"]
        let chunks = names.chunked(on: \.first!)
        print(chunks)
        // [("D", ["David"]), ("K", ["Kyle", "Karoy"]), ("N", ["Nate"])]
    }
    
    func testChunked3() throws {
        let names = ["David", "Kyle", "Karoy", "Nate"]
        let evenly = names.chunks(ofCount: 2)
        print(evenly)
        // equivalent to [["David", "Kyle"], ["Karoy", "Nate"]]

        let remaining = names.chunks(ofCount: 3)
        print(remaining)
        // equivalent to [["David", "Kyle", "Karoy"], ["Nate"]]
//        XCTAssertEqual(evenly, [["David", "Kyle"], ["Karoy", "Nate"]])
//        XCTAssertEqual(remaining, [["David", "Kyle", "Karoy"], ["Nate"]])
    }
}
