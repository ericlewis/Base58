public protocol Base58Encoding {
    func encode(bytes: [UInt8]) -> String
}

public protocol Base58Decoding {
    func decode(string: String) throws -> [UInt8]
}

public typealias Base58Coding = Base58Encoding & Base58Decoding
