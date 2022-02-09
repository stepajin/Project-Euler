// 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

// What is the sum of the digits of the number 2^1000?

struct Number: CustomDebugStringConvertible {
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
        let products: [Number] = left.digits.reversed().enumerated().lazy.map { offset, leftDigit in
            let product = [Number](repeating: right, count: leftDigit).reduce(.zero, +)
            let zeros = [Int](repeating: 0, count: offset)
            return Number(product.digits + zeros)			
        }
        return products.reduce(.zero, +)
    }
    
    func pow(_ pow: Int) -> Number {
        guard pow > 0 else { return Number(1) }
        return [Number](repeating: self, count: pow).reduce(Number(1), *)
    }
}

let product = Number(2).pow(1000)
let result = product.digits.reduce(0, +)
print(result)