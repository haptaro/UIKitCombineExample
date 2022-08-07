import Foundation

public struct Body: Decodable {
    public var current: Current
    
    public init(current: Current) {
        self.current = current
    }
    
    public enum CodingKeys: String, CodingKey {
        case current = "current"
    }
}


public struct Current: Decodable {
    public var condition: Condition
    
    public init(condition: Condition) {
        self.condition = condition
    }
    
    public enum CodingKeys: String, CodingKey {
        case condition = "condition"
    }
}

public struct Condition: Decodable {
    public var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}
