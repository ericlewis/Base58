import Foundation
import XCTest
@testable import Base58

final class Base58Tests: XCTestCase {
    private var validTestVectors: [ValidTestVector]!
    private var invalidTestVectors: [InvalidTestVector]!

    override func setUpWithError() throws {
        validTestVectors = try JSONDecoder().decode([ValidTestVector].self, from: validTestVectorData)
        invalidTestVectors = try JSONDecoder().decode([InvalidTestVector].self, from: invalidTestVectorData)
    }

    private func sut() -> Base58 {
        .init()
    }

    func testGivenValidTestVectors_WhenCount_ThenEqual11() {
        XCTAssertEqual(validTestVectors.count, 11)
    }

    func testGivenInvalidVectors_WhenCount_ThenEqual10() {
        XCTAssertEqual(invalidTestVectors.count, 10)
    }

    func testGivenValidVectorString_WhenEncode_ThenEqualVectorEncodedString() {
        let sut = self.sut()

        for testVector in validTestVectors {
            XCTAssertEqual(
                sut.encode(data: testVector.string.data(using: .utf8)!),
                testVector.encodedString
            )
        }
    }

    func testGivenValidVectorEncodedString_WhenDecode_ThenEqualVectorStringData() throws {
        let sut = self.sut()

        for testVector in validTestVectors {
            XCTAssertEqual(
                try sut.decode(string: testVector.encodedString),
                testVector.string.data(using: .utf8)!
            )
        }
    }

    func testGivenInvalidVectorEncodedString_WhenDecode_ThenThrowInvalidDecodingError() throws {
        let sut = self.sut()

        for testVector in invalidTestVectors {
            XCTAssertThrowsError(
                try sut.decode(string: testVector.encodedString)
            ) { error in
                XCTAssertEqual(
                    error as! Base58Error,
                    Base58Error.invalidDecoding
                )
            }
        }
    }

    func testGivenEncodedString_WithLeadingOnes_WhenDecode_ThenLeadingZeros() throws {
        XCTAssertEqual(
            try sut().decode(string: "11111111111111111111111111111111"),
            Data(repeating: 0, count: 32)
        )
    }
}
