// It is possible to show that the square root of two can be expressed as an infinite continued fraction.

// √2 = 1 + 1/(2 + 1/(2 + 1/(2+...)))

// By expanding this for the first four iterations, we get:

// 1 + 1/2 = 3/2 = 1.5

// 1 + 1/(2 + 1/2) = 7/5 = 1.4

// 1 + 1/(2 + 1/(2 + 1/2) = 17/12 = 1.41666...

// 1 + 1/(2 + 1/(2 + 1/(2 + 1/2) = 41/29 = 1.41379...

// The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.

// In the first one-thousand expansions, how many fractions contain a numerator with more digits than the denominator?

struct Number {
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

var fraction = (n: Number(1), d: Number(2))
var result = 0
for _ in (2...1000) {
    fraction = (n: fraction.d, d: fraction.d + fraction.d + fraction.n)
    let plus1 = (n: fraction.n + fraction.d, d: fraction.d)
    result += plus1.n.digits.count > plus1.d.digits.count ? 1 : 0
}
print(result)

