public struct GACalc {
    public private(set) var currentValue: Int
    
    public init(initialValue: Int = 0) {
        currentValue = initialValue
    }
    
    public mutating func add(_ value: Int) {
        currentValue += value
    }
    
    public mutating func subtract(_ value: Int) {
        currentValue -= value
    }
    
    public mutating func multiply(_ value: Int) {
        currentValue = currentValue * value
    }
    
    public mutating func divide(_ value: Int) {
        currentValue = currentValue / value
    }
    
    public mutating func negate() {
        currentValue.negate()
    }
}
