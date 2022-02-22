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
            let stringBytes = bytes(string: testVector.string)
            let encodedString = sut.encode(bytes: stringBytes)
            XCTAssertEqual(encodedString, testVector.encodedString)
        }
    }

    func testGivenValidVectorEncodedString_WhenDecode_ThenEqualVectorString() throws {
        let sut = self.sut()

        for testVector in validTestVectors {
            let decodedStringBytes = try sut.decode(string: testVector.encodedString)
            let testVectorStringBytes = bytes(string: testVector.string)
            XCTAssertEqual(decodedStringBytes, testVectorStringBytes)
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
        let encodedString = "11111111111111111111111111111111"
        let decodedStringBytes = try sut().decode(string: encodedString)
        let expectedBytes = Array<UInt8>(repeating: 0, count: 32)
        XCTAssertEqual(decodedStringBytes, expectedBytes)
    }
}

// MARK: - Helpers
fileprivate extension Base58Tests {
    func bytes(string: String) -> [UInt8] {
        [UInt8](string.utf8)
    }
}
