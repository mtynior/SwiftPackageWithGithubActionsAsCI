public struct GACalc {
    public private(set) var currentValue: Float
    
    public init(initialValue: Float = 0) {
        currentValue = initialValue
    }
    
    public mutating func add(_ value: Float) {
        currentValue += value
    }
    
    public mutating func subtract(_ value: Float) {
        currentValue -= value
    }
    
    public mutating func multiply(_ value: Float) {
        currentValue *= value
    }
    
    public mutating func divide(_ value: Float) {
        currentValue /=  value
    }
    
    public mutating func negate() {
        currentValue.negate()
    }
    
    public mutating func percentage() {
        currentValue *= 0.01
    }
}
