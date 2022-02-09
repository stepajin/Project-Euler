// The Fibonacci sequence is defined by the recurrence relation:

//  Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.

// Hence the first 12 terms will be:

//  F1 = 1
//  F2 = 1
//  F3 = 2
//  F4 = 3
//  F5 = 5
//  F6 = 8
//  F7 = 13
//  F8 = 21
//  F9 = 34
//  F10 = 55
//  F11 = 89
//  F12 = 144

// The 12th term, F12, is the first term to contain three digits.

// What is the index of the first term in the Fibonacci sequence to contain 1000 digits?

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
}

struct Fibbonaci: Sequence, IteratorProtocol {
    private var first: Number = .zero
    private var second: Number = .zero
    
    var last: Number { index > 0 ? second : .zero }
    private(set) var index = 0
    
    @discardableResult
    mutating func next() -> Number? {
        let result = index >= 2 ? first + second : Number(1)
        first = second
        second = result
        index += 1
        return result
    }
}

var fibbonaci = Fibbonaci()
while fibbonaci.last.digits.count < 1000 {
    fibbonaci.next()
}
let result = fibbonaci.index
print(result)