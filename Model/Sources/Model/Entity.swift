import Foundation

public struct Body: Decodable, Sendable {
    public var current: Current
    
    public init(current: Current) {
        self.current = current
    }
}


public struct Current: Decodable, Sendable {
    public var condition: Condition
    
    public init(condition: Condition) {
        self.condition = condition
    }
}

public struct Condition: Decodable, Sendable {
    public var text: String
    
    public init(text: String) {
        self.text = text
    }
}
