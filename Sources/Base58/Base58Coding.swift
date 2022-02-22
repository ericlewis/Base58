import Foundation

public protocol Base58Encoding {
    func encode(data: Data) -> String
}

public protocol Base58Decoding {
    func decode(string: String) throws -> Data
}

public typealias Base58Coding = Base58Encoding & Base58Decoding
