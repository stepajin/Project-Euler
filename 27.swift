// Euler discovered the remarkable quadratic formula: n^2 + n + 41

// It turns out that the formula will produce 40 primes for the consecutive integer values 0 <= n <=39. However, when n = 40, 40^2 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly divisible by 41.

// The incredible formula n^2 - 79n + 1601 was discovered, which produces 80 primes for the consecutive values 0 <= n <= 79. The product of the coefficients, −79 and 1601, is −126479.

// Considering quadratics of the form:
// n^2 + an + b, where |a| < 1000 and |b| <= 1000 
// where |n| is the modulus/absolute value of n
// e.g. |11| = 11 and |-4| = 4 

// Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.

// Sieve of Eratosthenes
// Odd numbers only
struct PrimeNumbers: Sequence, IteratorProtocol {
    private let bound: Int
    
    private var flags: [Bool]
    private var currentIndex: Int = -1
    private var count: Int { (bound-1)/2 }
    
    init(bound: Int) {
        self.bound = bound
        flags = [Bool](repeating: true, count: (bound-1)/2)
    }
    
    private func number(at index: Int) -> Int {
        2 * index + 3
    }
    
    private mutating func mark(from fromIndex: Int) {
        let number = number(at: fromIndex)
        let offset = number
        var idx = fromIndex + offset
        while idx <= count - 1 {
            flags[idx] = false
            idx += offset
        }
    }
    
    @discardableResult
    mutating func next() -> Int? {
        if currentIndex == -1 {
            currentIndex = 0
            return 2
        }
        if currentIndex >= count {
            return nil
        }
        guard let primeIndex = (currentIndex...count-1).first(where: { flags[$0] }) else {
            currentIndex = count
            return nil
        }
        let number = number(at: primeIndex)
        mark(from: primeIndex)
        currentIndex = primeIndex + 1
        return number
    }
}

let isPrimeMap = [Int: Bool](uniqueKeysWithValues: PrimeNumbers(bound: 200000).map { ($0, true) })
func isPrime(_ n: Int) -> Bool {
    isPrimeMap[n, default: false]
}

func quadraticFormula(a: Int, b: Int) -> ((Int) -> Int) {
    { n in n*n + a*n + b }
}

var maxCount = 0
var result = 0
for a in (-999...999) {
    for b in (-1000...1000) {
        let formula = quadraticFormula(a: a, b: b)
        var primesCount = 0
        var n = 0
        while isPrime(formula(n)) { 
            primesCount += 1
            n += 1 
        }
        if primesCount > maxCount {
            maxCount = primesCount
            result = a * b
        }
    }
}
print(result)

