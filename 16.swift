// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

// What is the sum of the digits of the number 2^1000?

struct Number: CustomDebugStringConvertible, Comparable, Strideable {
    static var zero: Number { Number([0]) }
    
    private(set) var digits: [Int]
    
    init(_ int: Int) {
        guard int > 0 else {
            self = .zero
            return
        }
        var number = int
        digits = []
        while number > 0 {
            let digit = number % 10
            digits.insert(digit, at: 0)
            number /= 10 
        }
    }
    
    init(_ digits: [Int]) {
        self.digits = digits
    }
    
    var debugDescription: String {
        digits.map(String.init).joined()
    }
    
    func advanced(by n: Int) -> Number {
        self + Number(n)
    }
    
    func distance(to other: Number) -> Int { 0 }
    
    static func +(left: Number, right: Number) -> Number {
        let digitsCount = max(left.digits.count, right.digits.count)
        let leftDigits = [Int](repeating: 0, count: digitsCount - left.digits.count) + left.digits
        let rightDigits = [Int](repeating: 0, count: digitsCount - right.digits.count) + right.digits
        var digits: [Int] = []
        var residue = 0
        for index in (0...digitsCount-1).reversed() {
            let sum = leftDigits[index] + rightDigits[index] + residue
            let digit = sum % 10
            residue = (sum - digit) / 10 
            digits.insert(digit, at: 0)
        }
        if residue > 0 {
            digits.insert(residue, at: 0)
        }
        return Number(digits)
    }
    
    static func *(left: Number, right: Number) -> Number {
        (Number(1)...right).lazy.map { _ in left }.reduce(.zero, +)
    }
    
    static func ==(left: Number, right: Number) -> Bool {
        left.digits == right.digits
    }
    
    static func <(left: Number, right: Number) -> Bool {
        left.digits.count == right.digits.count
            ? zip(left.digits, right.digits).first { $0 != $1 }.map(<) ?? false
            : left.digits.count < right.digits.count
    }

    func pow(_ pow: Int) -> Number {
        guard pow > 0 else { return Number(1) }
        return [Number](repeating: self, count: pow).reduce(Number(1), *)
    }
}

let product = Number(2).pow(1000)
let result = product.digits.reduce(0, +)
print(result)