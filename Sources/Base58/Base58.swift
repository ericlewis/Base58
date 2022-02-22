import Foundation
import BigInt

public struct Base58 {
    private static let alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
    private static let alphabetBytes = [UInt8](alphabet.utf8)
    private static let radix = BigUInt(alphabetBytes.count)

    public init() {}
}

// MARK: - Base58Encoding
extension Base58: Base58Encoding {
    public func encode(data: Data) -> String {
        var answer = [UInt8]()
        var integerBytes = BigUInt(data)

        while integerBytes > 0 {
            let (quotient, remainder) = integerBytes.quotientAndRemainder(dividingBy: Self.radix)
            answer.insert(Self.alphabetBytes[Int(remainder)], at: 0)
            integerBytes = quotient
        }

        let prefix = Array(data.prefix { $0 == 0 }).map { _ in Self.alphabetBytes[0] }
        answer.insert(contentsOf: prefix, at: 0)

        return String(bytes: answer, encoding: .utf8)!
    }
}

// MARK: - Base58Decoding
extension Base58: Base58Decoding {
    public func decode(string: String) throws -> Data {
        var answer = BigUInt(0)
        var i = BigUInt(1)

        let stringBytes = [UInt8](string.utf8)
        for character in stringBytes.reversed() {
            guard let alphabetIndex = Self.alphabetBytes.firstIndex(of: character) else {
                throw Base58Error.invalidDecoding
            }
            answer += (i * BigUInt(alphabetIndex))
            i *= Self.radix
        }

        let bytes = answer.serialize()
        let leadingOnes = stringBytes.prefix(while: { value in value == Self.alphabetBytes[0]})
        let leadingZeros = Data(repeating: 0, count: leadingOnes.count)
        return leadingZeros + bytes
    }
}
