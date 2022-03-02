// A googol (10^100) is a massive number: one followed by one-hundred zeros; 100100 is almost unimaginably large: one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.

// Considering natural numbers of the form, ab, where a, b < 100, what is the maximum digital sum?

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
        left.digits.count == right.digits.count
            ? zip(left.digits, right.digits).first { $0 != $1 } == nil
            : false
    }

    static func <(left: Number, right: Number) -> Bool {
        left.digits.count == right.digits.count
            ? zip(left.digits, right.digits).first { $0 != $1 }.map(<) ?? false
            : left.digits.count < right.digits.count
    }
}

func digitalSum(_ n: Number) -> Int {
    n.digits.reduce(0, +)
}

var result = 0
for a in Number(1)...Number(99) {
    var n = Number(1)
    for _ in 1..<100 {
        n = n * a
        let sum = digitalSum(n)
        if sum > result {
            result = sum
        }
    }
}
print(result)
